//
//  TypesCollectionViewCell.swift
//  tca-pokemon
//
//  Created by Devsisters on 2022/08/31.
//

import UIKit

import SnapKit

final class TypesCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: TypesCollectionViewCell.self)
    
    private let nameLabel: UILabel = {
       let view = UILabel()
        view.font = .systemFont(ofSize: 22, weight: .semibold)
        return view
    }()
    
    private let pokemonsStackView: UIStackView = {
       let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 8
        view.distribution = .fillProportionally
        view.alignment = .leading
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
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.borderWidth = 1.6
        contentView.layer.cornerRadius = 20
        
        addSubviews()
        configureConstraints()
    }
    
    private func addSubviews() {
        contentView.addSubviews([nameLabel, pokemonsStackView])
    }
    
    private func configureConstraints() {
        nameLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(contentView).offset(16)
        }
        pokemonsStackView.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(12)
            make.bottom.equalTo(contentView)
            make.trailing.equalTo(contentView).offset(-16)
        }
    }
    
    private func configurePokemonLabels(_ pokemon: String) {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.text = pokemon
        pokemonsStackView.addArrangedSubview(label)
    }
    
    func configure(with type: AbilityType) {
        nameLabel.text = type.name
        type.pokemons.forEach { configurePokemonLabels($0) }
    }
}
