//
//  MemoListTableViewCell.swift
//  MemoDemo
//
//  Created by delma on 2022/08/22.
//

import UIKit

import SnapKit

final class MemoListTableViewCell: UITableViewCell {

    static let identifier = "MemoListTableViewCell"
    
    private lazy var likeButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "star"), for: .normal)
        view.setImage(UIImage(systemName: "star.fill"), for: .selected)
        view.tintColor = .blue
        view.imageView?.contentMode = .scaleAspectFill
        view.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        return view
    }()
    
    private let memoLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }

    private func configure() {
        addSubviews()
        configureConstraints()
    }
    
    private func addSubviews() {
        contentView.addSubview(likeButton)
        contentView.addSubview(memoLabel)
    }
    
    private func configureConstraints() {
        likeButton.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(18)
            make.centerY.equalTo(contentView)
            make.top.bottom.equalTo(contentView).inset(12)
            make.width.equalTo(likeButton.snp.height)
        }
        
        memoLabel.snp.makeConstraints { make in
            make.leading.equalTo(likeButton.snp.trailing).offset(12)
            make.trailing.equalTo(contentView).offset(-18)
            make.centerY.equalTo(likeButton)
        }
    }
    
    @objc private func likeButtonTapped() {
        likeButton.isSelected.toggle()
        
        // TODO: 값 바꾸는 요청 보내야 함
    }
    
    func configure(with memo: MemoState) {
        likeButton.isSelected = memo.isLiked
        memoLabel.text = memo.contents
    }
}
