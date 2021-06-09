//
//  Service.swift
//  PokemonRestTest
//
//  Created by Viacheslav Markov on 30.05.2021.
//

import Foundation

class Service {
    
    static func getService<S: Decodable>(with request: URLRequest,
                                          completion: @escaping (Result<S, APIError>) -> Void) {
        
        let session = URLSession.shared
        session.dataTask(with: request) { data, response, error in
            
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(.server(error)))
                }
                return
            }
            
            if let pokemonResponse = response as? HTTPURLResponse,
               (400...500).contains(pokemonResponse.statusCode) {
                DispatchQueue.main.async {
                    completion(.failure(.response(pokemonResponse.statusCode)))
                }
                return
            }
            
            DispatchQueue.main.async {
                if let data = data {
                    do {
                        let jsonItem = try JSONDecoder().decode(S.self, from: data)
                        completion(.success(jsonItem))
                    } catch {
                        completion(.failure(.wrongType(String(describing: S.self))))
                    }
                } else {
                    completion(.failure(.noData))
                }
            }
        }.resume()
    }
}
