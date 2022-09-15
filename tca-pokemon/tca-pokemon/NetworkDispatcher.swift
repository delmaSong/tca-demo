//
//  NetworkDispatcher.swift
//  tca-pokemon
//
//  Created by Devsisters on 2022/08/31.
//

import Foundation

import ComposableArchitecture

enum Endpoint: String {
    
    static let defaultURL = "https://pokeapi.co/api/v2/"
    
    case pokemon
    case item
    case type
    
    var urlString: String {
        return Endpoint.defaultURL + self.rawValue
    }
}

struct NetworkClient {
    var fetchPokemonInfo: (_ id: Int) -> Effect<PokemonInfo, Never>
    var fetchItem: (_ id: Int) -> Effect<Item, Never>
    var fetchType: (_ id: Int) -> Effect<AbilityType, Never>
}

extension NetworkClient {
    static let live = Self(fetchPokemonInfo: { id in
        Effect.task {
            let (data, _) = try await URLSession.shared
                .data(from: URL(string: Endpoint.pokemon.urlString + "/\(id)")! )
            let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
            return PokemonInfo(
                name: pokemon.name,
                stat: "\(pokemon.stats.first?.base_stat ?? 0)",
                type: pokemon.types.first?.type.name ?? "",
                isLiked: false,
                imageURL: pokemon.sprites.other.official_artwork.front_default
            )
        }
        .eraseToEffect()
    }, fetchItem: { id in
        Effect.task {
            let (data, _) = try await URLSession.shared
                .data(from: URL(string: Endpoint.item.urlString + "/\(id)")! )
            return try JSONDecoder().decode(Item.self, from: data)
        }
        .eraseToEffect()
    }, fetchType: { id in
        Effect.task {
            let (data, _) = try await URLSession.shared
                .data(from: URL(string: Endpoint.type.urlString + "/\(id)")! )
            let type = try JSONDecoder().decode(`Type`.self, from: data)
            return AbilityType(name: type.name, pokemons: [type.pokemon.first!.pokemon.name])
        }
        .eraseToEffect()
    })
}
