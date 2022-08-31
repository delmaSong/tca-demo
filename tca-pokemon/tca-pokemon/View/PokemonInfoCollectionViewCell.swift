//
//  PokemonInfoCollectionViewCell.swift
//  tca-pokemon
//
//  Created by Devsisters on 2022/08/30.
//

import UIKit

import SnapKit

final class PokemonInfoCollectionViewCell: UICollectionViewCell {
   
    static let identifier = String(describing: PokemonInfoCollectionViewCell.self)
    
    private let backgroundColoredView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let pokemonImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private let nameLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 22, weight: .bold)
        return view
    }()
    
    private let statLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 16, weight: .semibold)
        return view
    }()
    
    private let typeLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 16, weight: .semibold)
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
            make.leading.equalTo(contentView)
            make.top.equalTo(contentView).offset(40)
            make.trailing.bottom.equalTo(contentView).offset(-6)
        }
        pokemonImageView.snp.makeConstraints { make in
            make.top.trailing.bottom.equalTo(contentView)
            make.width.equalTo(pokemonImageView.snp.height)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(backgroundColoredView).offset(32)
            make.leading.equalTo(contentView).offset(12)
        }
        statLabel.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
        }
        typeLabel.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel)
            make.top.equalTo(statLabel.snp.bottom).offset(8)
            make.bottom.lessThanOrEqualTo(backgroundColoredView).offset(12)
        }
        likeButton.snp.makeConstraints { make in
            make.trailing.bottom.equalTo(pokemonImageView)
            make.width.height.equalTo(32)
        }
    }
    
    @objc private func likeButtonTapped() {
        
    }
    
    func configure(with info: PokemonInfoState) {
        backgroundColoredView.backgroundColor = UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 0.3
        )
        nameLabel.text = info.name
        statLabel.text = "Stat: \(info.stat)"
        typeLabel.text = "Type: \(info.type)"
        likeButton.isSelected = info.isLiked
        
        guard let url = URL(string: info.imageURL) else { return }
        do {
            let data = try Data(contentsOf: url)
            pokemonImageView.image = UIImage(data: data)
        } catch { }
    }
}
