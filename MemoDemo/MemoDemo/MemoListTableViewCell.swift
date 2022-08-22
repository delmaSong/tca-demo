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
        view.imageView?.image = UIImage(named: "star")
        view.tintColor = .yellow
        view.imageView?.contentMode = .scaleAspectFit
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
            make.width.height.equalTo(25)
        }
        
        memoLabel.snp.makeConstraints { make in
            make.leading.equalTo(likeButton.snp.trailing).offset(12)
            make.trailing.equalTo(contentView).offset(-18)
            make.centerY.equalTo(likeButton)
        }
    }
    
    @objc private func likeButtonTapped() {
        likeButton.imageView?.image = likeButton.isSelected ? UIImage(named: "star.fill") : UIImage(named: "star")
    }
    
    func configure(with memo: MemoState) {
        likeButton.isSelected = memo.isLiked
        memoLabel.text = memo.contents
    }
}
