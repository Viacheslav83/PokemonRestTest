//
//  ShowViewModel.swift
//  PokemonRestTest
//
//  Created by Viacheslav Markov on 31.05.2021.
//

import Foundation

class ShowViewModel {
    
    var number: Int
    var name: String
    var itemAbility = [PokemonAbilitie]()
    
    var shortEffect: String?
    var effect: String?
    var updateCalback: ((Error?) -> Void)?
    
    init(number: Int, name: String) {
        self.number = number
        self.name = name
    }
    
    func getPokemonAbilitie() {
        let urlString = "https://pokeapi.co/api/v2/ability/\(number)/"
        PokemonService.fetchPokemonActivity(with: urlString) { result in
            switch result {
            case .success(let abilitie):
                let effect = abilitie.effectEntries
                self.shortEffect = effect[0].effect
                self.effect = effect[0].effect
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
