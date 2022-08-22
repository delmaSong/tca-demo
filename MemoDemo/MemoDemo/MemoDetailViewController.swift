//
//  MemoDetailViewController.swift
//  MemoDemo
//
//  Created by delma on 2022/08/22.
//

import UIKit

import SnapKit

final class MemoDetailViewController: UIViewController {

    private let memoTextView: UITextView = {
        let view = UITextView()
        view.isEditable = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        view.backgroundColor = .systemPink
    }
    
    private func configure() {
        
        view.addSubview(memoTextView)
        
        memoTextView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.bottom.equalTo(view)
        }
    }
}
