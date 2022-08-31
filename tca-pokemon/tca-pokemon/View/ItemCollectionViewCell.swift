//
//  ItemCollectionViewCell.swift
//  tca-pokemon
//
//  Created by Devsisters on 2022/08/31.
//

import UIKit

import SnapKit

final class ItemCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: ItemCollectionViewCell.self)
    
    private let roundBackgroundView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 50
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowRadius = 4
        view.layer.shadowOpacity = 0.4
        view.layer.shadowOffset = CGSize(width: 6, height: 10)
        view.backgroundColor = .white
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
            make.edges.equalTo(contentView)
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
