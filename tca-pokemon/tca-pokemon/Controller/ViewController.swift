//
//  ViewController.swift
//  tca-pokemon
//
//  Created by Devsisters on 2022/08/30.
//

import UIKit

import SnapKit
import ComposableArchitecture
import Combine

final class ViewController: UIViewController {
    private let viewStore: ViewStore<AppState, AppAction>
    private var cancellables: Set<AnyCancellable> = []
    
    private let wholeScrollView = UIScrollView()
    
    private let pokemonsLabel: UILabel = {
        let view = UILabel()
        view.text = "Pokemons"
        view.font = .systemFont(ofSize: 32, weight: .bold)
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
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    private let itemsLabel: UILabel = {
        let view = UILabel()
        view.text = "Items"
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
        view.text = "Types"
        view.font = .systemFont(ofSize: 32, weight: .bold)
        return view
    }()
    
    private lazy var typeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 40, height: 100)
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(
            TypesCollectionViewCell.self,
            forCellWithReuseIdentifier: TypesCollectionViewCell.identifier
        )
        view.dataSource = self
        view.isScrollEnabled = false
        return view
    }()
    
    init(store: Store<AppState, AppAction>) {
        self.viewStore = ViewStore(store)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        
        (1...10).map { $0 }.forEach { id in
            viewStore.send(.loadAll(id: id))
        }
        
        viewStore.publisher.pokemonInfos
            .sink { [weak self] _ in
                self?.pokemonInfoCollectionView.reloadData()
            }
            .store(in: &cancellables)
        
        viewStore.publisher.items
            .sink { [weak self] _ in
                self?.itemCollectionView.reloadData()
            }
            .store(in: &cancellables)
        
        viewStore.publisher.types
            .sink { [weak self] _ in
                self?.typeCollectionView.reloadData()
            }
            .store(in: &cancellables)
    }
    
    private func configure() {
        view.backgroundColor = .white
        
        addSubviews()
        configureConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(wholeScrollView)
        wholeScrollView.addSubviews([
            pokemonsLabel,
            pokemonInfoCollectionView,
            itemsLabel,
            itemCollectionView,
            typesLabel,
            typeCollectionView
        ])
    }
    
    private func configureConstraints() {
        wholeScrollView.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view)
        }
        pokemonsLabel.snp.makeConstraints { make in
            make.leading.equalTo(wholeScrollView).offset(32)
            make.top.equalTo(wholeScrollView.contentLayoutGuide)
            make.height.equalTo(60)
        }
        pokemonInfoCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view)
            make.top.equalTo(pokemonsLabel.snp.bottom)
            make.height.equalTo(UIScreen.main.bounds.width * 0.6)
        }
        itemsLabel.snp.makeConstraints { make in
            make.leading.height.equalTo(pokemonsLabel)
            make.top.equalTo(pokemonInfoCollectionView.snp.bottom).offset(22)
        }
        itemCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view)
            make.top.equalTo(itemsLabel.snp.bottom)
            make.height.equalTo(130)
        }
        typesLabel.snp.makeConstraints { make in
            make.leading.height.equalTo(pokemonsLabel)
            make.top.equalTo(itemCollectionView.snp.bottom).offset(22)
        }
        typeCollectionView.snp.makeConstraints { make in
            make.trailing.equalTo(view)
            make.leading.equalTo(view)
            make.top.equalTo(typesLabel.snp.bottom).offset(12)
            make.bottom.equalTo(wholeScrollView.contentLayoutGuide)
            make.height.equalTo(1000)
        }
    }
    
}

// MARK: - UICollectionViewDataSource

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == pokemonInfoCollectionView {
            return viewStore.pokemonInfos.count
        } else if collectionView == itemCollectionView {
            return viewStore.items.count
        } else {
            return viewStore.types.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == pokemonInfoCollectionView {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PokemonInfoCollectionViewCell.identifier,
                for: indexPath
            ) as! PokemonInfoCollectionViewCell
            cell.configure(with: viewStore.pokemonInfos[indexPath.item])
            return cell
        } else if collectionView == itemCollectionView {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ItemCollectionViewCell.identifier,
                for: indexPath
            ) as! ItemCollectionViewCell
            cell.configure(item: viewStore.items[indexPath.item].sprites.default)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TypesCollectionViewCell.identifier,
                for: indexPath
            ) as! TypesCollectionViewCell
            cell.configure(with: viewStore.types[indexPath.item])
            return cell
        }
    }
    
}
