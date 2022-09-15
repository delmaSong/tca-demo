//
//  PokemonInfo.swift
//  tca-pokemon
//
//  Created by Devsisters on 2022/08/30.
//

import ComposableArchitecture
import SwiftUI

enum HomeSection {
    case pokemonInfo, item, type
}

struct AppState: Equatable {
    var pokemonInfos: [PokemonInfo]
    var items: [Item]
    var types: [AbilityType]
}

enum AppAction {
    case loadAll(id: Int)
    case loadPokemonInfo(Result<PokemonInfo, NSError>)
    case loadItem(Result<Item, NSError>)
    case loadType(Result<AbilityType, NSError>)
    case like(at: HomeSection, id: Int)
}

struct AppEnvironment {
    let client: NetworkClient
    var backgroundQueue: AnySchedulerOf<DispatchQueue> = DispatchQueue.global(qos: .background)
      .eraseToAnyScheduler()
    var mainQueue: AnySchedulerOf<DispatchQueue> = .main
}

let appReducer = Reducer<AppState, AppAction, AppEnvironment> { state, action, environment in
    switch action {
    case .loadAll(let id):
        return .concatenate([
            environment.client.fetchPokemonInfo(id)
                .subscribe(on: environment.backgroundQueue)
                .receive(on: environment.mainQueue.animation())
                .eraseToAnyPublisher()
                .eraseToEffect()
                .map { output in
                    AppAction.loadPokemonInfo(.success(output))
                },
            environment.client.fetchItem(id)
                .subscribe(on: environment.backgroundQueue)
                .receive(on: environment.mainQueue.animation())
                .eraseToAnyPublisher()
                .eraseToEffect()
                .map { output in
                    AppAction.loadItem(.success(output))
                },
            environment.client.fetchType(id)
                .subscribe(on: environment.backgroundQueue)
                .receive(on: environment.mainQueue.animation())
                .eraseToAnyPublisher()
                .eraseToEffect()
                .map { output in
                    AppAction.loadType(.success(output))
                }
        ])
        
    case .loadPokemonInfo(.success(let info)):
        state.pokemonInfos.append(info)
        return .none
        
    case .like(let section, let id):
        switch section {
        case .pokemonInfo:
            var info = state.pokemonInfos[id]
            info.isLiked.toggle()
            
            state.pokemonInfos.remove(at: id)
            state.pokemonInfos.insert(info, at: id)
        default: break
        }
        return .none
    case .loadPokemonInfo(.failure):
        return .none
        
    case .loadItem(.success(let item)):
        state.items.append(item)
        return .none
        
    case .loadItem(.failure):
        return .none
        
    case .loadType(.success(let type)):
        state.types.append(type)
        return .none
        
    case .loadType(.failure):
        return .none
        
    }
}

// MARK: - PokemonInfo

struct PokemonInfo: Equatable {
    var name: String
    var stat: String
    var type: String
    var isLiked: Bool
    var imageURL: String
}

enum PokemonInfoAction {
    case like
}

// MARK: - Type

struct AbilityType: Equatable {
    var name: String
    var pokemons: [String]
}
