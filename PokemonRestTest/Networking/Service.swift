//
//  Service.swift
//  PokemonRestTest
//
//  Created by Viacheslav Markov on 30.05.2021.
//

import Foundation

class Service {
    
    static func getPokemons(with request: URLRequest, completion: @escaping (Result<PokemonItem, APIError>) -> Void) {
        
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
                        let jsonPokemon = try JSONDecoder().decode(PokemonItem.self, from: data)
                        completion(.success(jsonPokemon))
                    } catch {
                        completion(.failure(.wrongType(String(describing: PokemonItem.self))))
                    }
                } else {
                    completion(.failure(.noData))
                }
            }
        }.resume()
    }
    
    static func getAbilitiesPokemon(with request: URLRequest, completion: @escaping (Result<PokemonAbilitie, APIError>) -> Void) {
        
//        guard let url = URL(string: url) else { return }
        
        let session = URLSession.shared
        session.dataTask(with: request) { data, response, error in
            
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(.server(error)))
                }
                return
            }
            
            if let abilityResponce = response as? HTTPURLResponse,
               (400...500).contains(abilityResponce.statusCode) {
                DispatchQueue.main.async {
                    completion(.failure(.response(abilityResponce.statusCode)))
                }
                return
            }
            
            DispatchQueue.main.async {
                if let data = data {
                    do {
                        let jsonAbilities = try JSONDecoder().decode(PokemonAbilitie.self, from: data)
                        completion(.success(jsonAbilities))
                    } catch {
                        completion(.failure(.wrongType(String(describing: PokemonAbilitie.self))))
                    }
                } else {
                    completion(.failure(.noData))
                }
            }
        }.resume()
    }
}
