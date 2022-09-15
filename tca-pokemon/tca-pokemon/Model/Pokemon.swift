//
//  Pokemon.swift
//  tca-pokemon
//
//  Created by Devsisters on 2022/09/01.
//

import Foundation

struct Pokemon: Decodable {
    var name: String
    var stats: [Stat]
    var sprites: Sprites
    var types: [TypeWrapper]
    
    struct Stat: Decodable {
        var base_stat: Int
    }
    
    struct Sprites: Decodable {
        var other: Other
        
        struct Other: Decodable {
            var official_artwork: Artwork
            
            enum CodingKeys: String, CodingKey {
                case official_artwork = "official-artwork"
            }
            
            struct Artwork: Decodable {
                var front_default: String
            }
        }
    }
    
    struct TypeWrapper: Decodable {
        var type: `Type`
        
        struct `Type`: Decodable {
            var name: String
        }
    }
}

struct Item: Decodable, Equatable {
    var sprites: Sprites
    
    struct Sprites: Decodable, Equatable {
        var `default`: String
    }
}

struct `Type`: Decodable {
    var name: String
    var pokemon: [PokemonWrapper]
    
    struct PokemonWrapper: Decodable {
        var pokemon: Pokemon
        
        struct Pokemon: Decodable {
            var name: String
        }
    }
}
