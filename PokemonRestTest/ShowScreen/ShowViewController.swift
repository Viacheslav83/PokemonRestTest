//
//  showViewController.swift
//  PokemonRestTest
//
//  Created by Viacheslav Markov on 31.05.2021.
//

import UIKit

class ShowViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var effectLabel: UILabel!
    @IBOutlet weak var shortEffectLabel: UILabel!
    
    var viewModel: ShowViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = viewModel?.name
        pokemonImageView.image = UIImage(named: "defaultPokemon")
        
        viewModel?.subscribe(updateCalback: { error in
            if let error = error {
                print(error)
                return
            }
            self.effectLabel.text = self.viewModel?.effect
            self.shortEffectLabel.text = self.viewModel?.shortEffect
        })
        
        DispatchQueue.main.async {
            self.pokemonImageView.image = UIImage(data: self.viewModel?.data ?? Data())
        }
    }

}
