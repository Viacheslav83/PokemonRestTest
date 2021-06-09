//
//  ShowViewModel.swift
//  PokemonRestTest
//
//  Created by Viacheslav Markov on 31.05.2021.
//

import Foundation

class ShowViewModel {
    
    var number: Int
    var data: Data
    var name: String
    
    var itemAbility = [PokemonAbilitie]()
    let pokemonImgeUrl = "https://pokeapi.co/api/v2/pokemon-form/"
    var urlImage: String?
    
    var shortEffect: String?
    var effect: String?
    var updateCalback: ((Error?) -> Void)?
    
    init(data: Data, name: String, number: Int) {
        self.data = data
        self.name = name
        self.number = number
        
        getPokemonAbilitie()
    }
    
    func getPokemonAbilitie() {
        let urlString = "https://pokeapi.co/api/v2/ability/\(number)/"
        PokemonService.fetchPokemonActivity(with: urlString) { result in
            switch result {
            case .success(let abilitie):
                let effect = abilitie.effectEntries
                self.shortEffect = effect.last?.effect
                self.effect = effect.last?.effect
                self.updateCalback?(nil)
            case .failure(let error):
                self.updateCalback?(error)
            }
        }
    }
    
    func subscribe(updateCalback: @escaping (Error?) -> Void) {
        self.updateCalback = updateCalback
    }
}
