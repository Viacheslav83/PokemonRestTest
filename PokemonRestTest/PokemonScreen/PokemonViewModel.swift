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
    
    var cach = [Int: Data]()
    var pokemonImageUrl = "https://pokeapi.co/api/v2/pokemon-form/"
    
    func getPokemon(with urlString: String? = nil) {
        PokemonService.getURLString(with: urlString)
        PokemonService.fetchPokemon(completion: { result in
            switch result {
            case .success(let pokemons):
                self.pokemons = pokemons.results
                self.nextPageURLString = pokemons.next
                self.previousPageURLString = pokemons.previous
                self.updateCallback?(nil)
            case .failure(let error):
                self.updateCallback?(error)
            }
        })
    }
    
    func subscribe(updateCallback: @escaping ((Error?) -> Void)) {
        self.updateCallback = updateCallback
    }
    
    func fetchImagePokemon(at index: Int, comletion: @escaping (Data) -> Void) {
            getData(at: index, comletion: comletion)
    }
    
    func getNumberPokemon(at index: Int) -> Int {
        return pokemons[index].urlString
            .components(separatedBy: "/")
            .compactMap {Int($0)}
            .last ?? 0
    }
    
    private func getData(at index: Int, comletion: @escaping (Data) -> Void) {
        let url = pokemonImageUrl + "\(getNumberPokemon(at: index))"
        PokemonService.fetchImagePokemon(with: url) { result in
            switch result {
            case .success(let pokemonFont):
                self.handleSuccessResult(at: index, with: pokemonFont.sprites.backShiny,
                                         comletion: comletion)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func handleSuccessResult(at index: Int,
                                     with urlString: String,
                                     comletion: @escaping (Data) -> Void) {

        DispatchQueue.global().async {
            guard let url = URL(string: urlString),
                  let data = try? Data(contentsOf: url)
            else { return }
                    self.cach[index] = data
            DispatchQueue.main.async {
                comletion(data)
            }
        }
    }
}
