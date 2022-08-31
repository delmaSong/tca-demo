//
//  ItemCollectionViewCell.swift
//  tca-pokemon
//
//  Created by Devsisters on 2022/08/31.
//

import UIKit

import SnapKit

final class ItemCollectionViewCell: UICollectionViewCell {
    
    private let roundBackgroundView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 50
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowRadius = 50
        view.layer.shadowOpacity = 1
        return view
    }()
    
    private let itemImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        contentView.addSubviews([roundBackgroundView, itemImageView])
    }
    
    private func configureConstraints() {
        roundBackgroundView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        itemImageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView).offset(12)
        }
    }
    
    func configure(item urlString: String) {
        if let url = URL(string: urlString) {
            do {
                let data = try Data(contentsOf: url)
                itemImageView.image = UIImage(data: data)
            } catch { }
        }
    }
}
