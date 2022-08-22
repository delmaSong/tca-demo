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
    let viewStore: ViewStore<ViewerState, ViewerAction>
    var cancellables: Set<AnyCancellable> = []
    
    private let memoTextView: UITextView = {
        let view = UITextView()
        view.font = UIFont.systemFont(ofSize: 22)
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
    }
    
    private func configure() {
        view.backgroundColor = .white
        
        view.addSubview(memoTextView)
        
        memoTextView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.bottom.equalTo(view)
        }
        
        memoTextView.text = viewStore.memo?.contents
        memoTextView.isEditable = viewStore.memo == nil && viewStore.status != .normal
        
        viewStore.publisher.status
            .sink { [weak self] status in
                let title = status == .normal ? "편집" : "저장"
                
                self?.navigationItem.rightBarButtonItem = UIBarButtonItem(
                    title: title,
                    style: UIBarButtonItem.Style.plain,
                    target: self,
                    action: #selector(self?.rightBarButtonTapped)
                )
            }.store(in: &cancellables)
    }
    
    @objc private func rightBarButtonTapped() {
        viewStore.send(viewStore.status == .normal ? .editButtonTapped : .saveButtonTapped(contents: memoTextView.text))
    }
}
