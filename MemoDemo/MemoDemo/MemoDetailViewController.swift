//
//  MemoDetailViewController.swift
//  MemoDemo
//
//  Created by delma on 2022/08/22.
//

import UIKit

import ComposableArchitecture
import SnapKit

final class MemoDetailViewController: UIViewController {
    let viewStore: ViewStore<ViewerState, ViewerAction>
    
    private let memoTextView: UITextView = {
        let view = UITextView()
        view.isEditable = false
        return view
    }()
    
    init(store: Store<ViewerState, ViewerAction>) {
        self.viewStore = ViewStore(store)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        
        memoTextView.text = viewStore.memo?.contents
    }
}
