//
//  MemoDetailViewController.swift
//  MemoDemo
//
//  Created by delma on 2022/08/22.
//

import UIKit

import ComposableArchitecture
import Combine
import SnapKit

final class MemoDetailViewController: UIViewController {
    let viewStore: ViewStore<MemoState, MemoAction>
    var cancellables: Set<AnyCancellable> = []
    
    private let memoTextView: UITextView = {
        let view = UITextView()
        view.font = UIFont.systemFont(ofSize: 22)
        return view
    }()
    
    private lazy var likeButton: UIButton = {
       let view = UIButton()
        view.setImage(UIImage(systemName: "star"), for: .normal)
        view.setImage(UIImage(systemName: "star.fill"), for: .selected)
        view.tintColor = .systemGreen
        view.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        
        var configuration = UIButton.Configuration.plain()
        configuration.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 30)
        view.configuration = configuration
        return view
    }()
    
    init(store: Store<MemoState, MemoAction>) {
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
        memoTextView.text = viewStore.contents
        
        addSubviews()
        configureConstraints()
        bind()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "save",
            style: UIBarButtonItem.Style.plain,
            target: self,
            action: #selector(rightBarButtonTapped)
        )
    }
    
    private func addSubviews() {
        view.addSubview(memoTextView)
        view.addSubview(likeButton)
    }
    
    private func configureConstraints() {
        memoTextView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.bottom.equalTo(view)
        }
        likeButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view).inset(32)
            make.width.height.equalTo(20)
        }
    }
    
    private func bind() {
//        viewStore.publisher.status
//            .sink { [weak self] status in
//                let isNormal = status == .normal
//                let title = isNormal ? "편집" : "저장"
//                self?.memoTextView.isEditable = !isNormal
//                self?.likeButton.isEnabled = isNormal
//
//                self?.navigationItem.rightBarButtonItem = UIBarButtonItem(
//                    title: title,
//                    style: UIBarButtonItem.Style.plain,
//                    target: self,
//                    action: #selector(self?.rightBarButtonTapped)
//                )
//            }.store(in: &cancellables)
    }
    
    @objc private func rightBarButtonTapped() {
        viewStore.send(.save(contents: memoTextView.text ?? ""))
    }
    
    @objc private func likeButtonTapped() {
        likeButton.isSelected.toggle()
    }
}
