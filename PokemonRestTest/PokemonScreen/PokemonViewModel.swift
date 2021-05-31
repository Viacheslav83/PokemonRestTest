//
//  PokemonViewModel.swift
//  PokemonRestTest
//
//  Created by Viacheslav Markov on 30.05.2021.
//

import Foundation

class PokemonViewModel {
    
    private var updateCallback: ((Error?) -> Void)?
    var pokemons = [Pokemon]()
    var nextPageURLString: String?
    var previousPageURLString: String?
    
    func getPokemon(with urlString: String? = nil) {
        Service.getURLString(with: urlString)
        Service.getPokemons { result in
            switch result {
            case .success(let pokemons):
                self.pokemons = pokemons.results
                self.nextPageURLString = pokemons.next
                self.previousPageURLString = pokemons.previous
                self.updateCallback?(nil)
            case .failure(let error):
                self.updateCallback?(error)
            }
        }
    }
    
    func subscribe(updateCallback: @escaping ((Error?) -> Void)) {
        self.updateCallback = updateCallback
    }
}
