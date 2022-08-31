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

final class ViewController: UIViewController {
    
    private let wholeScrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = .systemPink
        return view
    }()
    
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
        view.addSubviews([wholeScrollView, pokemonInfoCollectionView])
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
    }
    
}

// MARK: - UICollectionViewDataSource

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        info.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PokemonInfoCollectionViewCell.identifier,
            for: indexPath
        ) as! PokemonInfoCollectionViewCell
        cell.configure(with: info[indexPath.item])
        return cell
    }
    
}
