//
//  MemoListViewController.swift
//  MemoDemo
//
//  Created by delma on 2022/08/22.
//

import UIKit

import SnapKit

final class MemoListViewController: UIViewController {

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
