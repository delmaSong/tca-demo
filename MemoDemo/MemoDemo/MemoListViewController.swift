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
    let viewStore: ViewStore<EditorState, EditorAction>

    init(store: Store<EditorState, EditorAction>) {
      self.viewStore = ViewStore(store)
      super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let memoListTableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.register(MemoListTableViewCell.self, forCellReuseIdentifier: MemoListTableViewCell.identifier)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }
    
    private func configure() {
        view.backgroundColor = .white
        
        navigationController?.navigationBar.topItem?.title = "목록"
        
        view.addSubview(memoListTableView)
        
        memoListTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.bottom.equalTo(view)
        }
    }

}
