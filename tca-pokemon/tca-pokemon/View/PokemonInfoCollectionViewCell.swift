//
//  PokemonInfoCollectionViewCell.swift
//  tca-pokemon
//
//  Created by Devsisters on 2022/08/30.
//

import UIKit

import SnapKit

final class PokemonInfoCollectionViewCell: UICollectionViewCell {
   
    private let backgroundColoredView = UIView()
    
    private let pokemonImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private let nameLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 18, weight: .semibold)
        return view
    }()
    
    private let statLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 14, weight: .medium)
        return view
    }()
    
    
    private let typeLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 14, weight: .medium)
        return view
    }()
    
    private lazy var likeButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(named: "heart"), for: .normal)
        view.setImage(UIImage(named: "heart.fill"), for: .selected)
        view.tintColor = .red
        view.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
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
        contentView.addSubviews([
            backgroundColoredView,
            pokemonImageView,
            nameLabel,
            statLabel,
            typeLabel,
            likeButton
        ])
    }
    
    private func configureConstraints() {
        backgroundColoredView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(contentView)
            make.top.equalTo(contentView).offset(24)
        }
        pokemonImageView.snp.makeConstraints { make in
            make.top.trailing.bottom.equalTo(contentView).offset(12)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(backgroundColoredView).offset(12)
        }
        statLabel.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel)
            make.top.equalTo(nameLabel).offset(8)
        }
        typeLabel.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel)
            make.top.equalTo(statLabel).offset(8)
            make.bottom.greaterThanOrEqualTo(backgroundColoredView).offset(12)
        }
        likeButton.snp.makeConstraints { make in
            make.trailing.bottom.equalTo(pokemonImageView)
            make.width.height.equalTo(32)
        }
    }
    
    @objc private func likeButtonTapped() {
        
    }
}
