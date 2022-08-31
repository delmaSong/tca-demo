//
//  ViewController.swift
//  tca-pokemon
//
//  Created by Devsisters on 2022/08/30.
//

import UIKit

import SnapKit

let info: [PokemonInfoState] = [
    PokemonInfoState(name: "피카츄", stat: "99", type: "전기", isLiked: false, imageURL: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/22.png"),
    PokemonInfoState(name: "라이츄", stat: "99", type: "전기", isLiked: false, imageURL: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/2.png"),
    PokemonInfoState(name: "파이리", stat: "99", type: "전기", isLiked: false, imageURL: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/3.png"),
    PokemonInfoState(name: "꼬부기", stat: "99", type: "전기", isLiked: false, imageURL: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/4.png"),
]

let items: [String] = [
    "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/items/master-ball.png",
    "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/items/ultra-ball.png",
    "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/items/premier-ball.png",
    "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/items/lemonade.png",
    ]

let types: [AbilityTypeState] = [
    AbilityTypeState(name: "전기", pokemons: ["피카츄", "라이츄", "에렉몬"]),
    AbilityTypeState(name: "물", pokemons: ["꼬부기", "어니부기", "거북왕"]),
    AbilityTypeState(name: "풀", pokemons: ["이상해씨", "이상해꽃", "이상해풀"]),
    AbilityTypeState(name: "불", pokemons: ["파이리", "리자드", "리자몽"]),
    AbilityTypeState(name: "전기", pokemons: ["피카츄", "라이츄", "에렉몬"]),
    AbilityTypeState(name: "물", pokemons: ["꼬부기", "어니부기", "거북왕"]),
    AbilityTypeState(name: "풀", pokemons: ["이상해씨", "이상해꽃", "이상해풀"]),
    AbilityTypeState(name: "불", pokemons: ["파이리", "리자드", "리자몽"]),
]

final class ViewController: UIViewController {
    
    private let wholeScrollView = UIScrollView()
    
    private lazy var pokemonInfoCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let frameWidth = UIScreen.main.bounds.width
        layout.itemSize = CGSize(width: frameWidth * 0.8, height: frameWidth * 0.6)
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(
            PokemonInfoCollectionViewCell.self,
            forCellWithReuseIdentifier: PokemonInfoCollectionViewCell.identifier
        )
        view.dataSource = self
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    private let itemsLabel: UILabel = {
       let view = UILabel()
        view.text = "items"
        view.font = .systemFont(ofSize: 32, weight: .bold)
        return view
    }()
    
    private lazy var itemCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        layout.minimumLineSpacing = 22
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(
            ItemCollectionViewCell.self,
            forCellWithReuseIdentifier: ItemCollectionViewCell.identifier
        )
        view.dataSource = self
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    private let typesLabel: UILabel = {
       let view = UILabel()
        view.text = "types"
        view.font = .systemFont(ofSize: 32, weight: .bold)
        return view
    }()
    
    private lazy var typeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 120)
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(
            TypesCollectionViewCell.self,
            forCellWithReuseIdentifier: TypesCollectionViewCell.identifier
        )
        view.dataSource = self
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    private func configure() {
        view.backgroundColor = .white
        
        addSubviews()
        configureConstraints()
    }
    
    private func addSubviews() {
        view.addSubviews([
            wholeScrollView,
            pokemonInfoCollectionView,
            itemsLabel,
            itemCollectionView,
            typesLabel,
            typeCollectionView
        ])
    }
    
    private func configureConstraints() {
        wholeScrollView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        pokemonInfoCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(wholeScrollView)
            make.top.equalTo(wholeScrollView.contentLayoutGuide)
            make.height.equalTo(UIScreen.main.bounds.width * 0.7)
        }
        itemsLabel.snp.makeConstraints { make in
            make.leading.equalTo(wholeScrollView).offset(32)
            make.top.equalTo(pokemonInfoCollectionView.snp.bottom).offset(22)
            make.height.equalTo(80)
        }
        itemCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(wholeScrollView)
            make.top.equalTo(itemsLabel.snp.bottom)
            make.height.equalTo(130)
        }
        typesLabel.snp.makeConstraints { make in
            make.leading.height.equalTo(itemsLabel)
            make.top.equalTo(itemCollectionView.snp.bottom)
        }
        typeCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(wholeScrollView).inset(22)
            make.top.equalTo(typesLabel.snp.bottom)
            make.bottom.equalTo(wholeScrollView.contentLayoutGuide)
        }
    }
    
}

// MARK: - UICollectionViewDataSource

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == pokemonInfoCollectionView {
            return info.count
        } else if collectionView == itemCollectionView {
            return items.count
        } else {
            return types.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == pokemonInfoCollectionView {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PokemonInfoCollectionViewCell.identifier,
                for: indexPath
            ) as! PokemonInfoCollectionViewCell
            cell.configure(with: info[indexPath.item])
            return cell
        } else if collectionView == itemCollectionView {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ItemCollectionViewCell.identifier,
                for: indexPath
            ) as! ItemCollectionViewCell
            cell.configure(item: items[indexPath.item])
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TypesCollectionViewCell.identifier,
                for: indexPath
            ) as! TypesCollectionViewCell
            cell.configure(with: types[indexPath.item])
            return cell
        }
    }
    
}
