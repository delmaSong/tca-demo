//
//  NetworkDispatcher.swift
//  tca-pokemon
//
//  Created by Devsisters on 2022/08/31.
//

import Foundation

enum Endpoint: String {
    
    static let defaultURL = "https://pokeapi.co/api/v2/"
    
    case pokemon
    case item
    case type
    
    var urlString: String {
        return Endpoint.defaultURL + self.rawValue
    }
}

enum NetworkError: Error {
    case noValue
    case decodedError
}

struct NetworkDispatcher {
    func request<T: Decodable>(
        endpoint: Endpoint,
        id: String,
        dataType: T.Type,
        handler: @escaping (Result<T, Error>) -> Void
    ) {
        guard let url = URL(string: endpoint.urlString + "/\(id)") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                handler(.failure(error))
                return
            }
            
            guard let data = data else {
                handler(.failure(NetworkError.noValue))
                return
            }
                        
            guard let decodedData = try? JSONDecoder().decode(dataType, from: data) else {
                handler(.failure(NetworkError.decodedError))
                return
            }
            
            handler(.success(decodedData))
            
        }.resume()
    }
}
