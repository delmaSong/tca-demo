//
//  MemoListViewController.swift
//  MemoDemo
//
//  Created by delma on 2022/08/22.
//

import UIKit

import ComposableArchitecture
import SnapKit

final class MemoListViewController: UIViewController {
    let viewStore: ViewStore<MemoListState, MemoListAction>

    private lazy var memoListTableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.register(MemoListTableViewCell.self, forCellReuseIdentifier: MemoListTableViewCell.identifier)
        view.dataSource = self
        view.delegate = self
        view.rowHeight = 80
        return view
    }()
    
    private lazy var addButton: UIButton = {
       let view = UIButton()
        view.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        view.tintColor = .systemPink
        view.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        
        var configuration = UIButton.Configuration.plain()
        configuration.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 40)
        view.configuration = configuration
        return view
    }()
    
    init(store: Store<MemoListState, MemoListAction>) {
      self.viewStore = ViewStore(store)
      super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }
    
    private func configure() {
        view.backgroundColor = .white
        navigationController?.navigationBar.topItem?.title = "목록"
        
        addSubviews()
        configureConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(memoListTableView)
        view.addSubview(addButton)
    }
    
    private func configureConstraints() {
        memoListTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.bottom.equalTo(view)
        }
        addButton.snp.makeConstraints { make in
            make.trailing.bottom.equalTo(view).inset(22)
            make.width.height.equalTo(60)
        }
    }
    
    @objc private func addButtonTapped() {
        let detailVC = MemoDetailViewController(
            store: Store(
                initialState: ViewerState(
                    status: .edit,
                    memo: nil),
                reducer: viewerReducer,
                environment: ViewerEnvironment()
            )
        )
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension MemoListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewStore.memos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MemoListTableViewCell.identifier, for: indexPath) as! MemoListTableViewCell
        cell.configure(with: viewStore.memos[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = MemoDetailViewController(
            store: Store(
                initialState: ViewerState(
                    status: .normal,
                    memo: viewStore.memos[indexPath.row]),
                reducer: viewerReducer,
                environment: ViewerEnvironment()
            )
        )
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
