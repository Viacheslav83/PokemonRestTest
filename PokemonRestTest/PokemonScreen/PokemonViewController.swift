//
//  ViewController.swift
//  PokemonRestTest
//
//  Created by Viacheslav Markov on 30.05.2021.
//

import UIKit

class PokemonViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: PokemonViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupHeaderTableView()
        setupTableView()
        
        viewModel = PokemonViewModel()
        
        viewModel?.subscribe { error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            self.tableView.reloadData()
        }
        viewModel?.getPokemon()
    }
    
    private func setupHeaderTableView() {
        let frameView = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 60)
        let headerView = UIView(frame: frameView)
        headerView.backgroundColor = .systemGray6
        
        let label = UILabel(frame: frameView)
        label.text = "Pokemons"
        label.font = .boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        
        headerView.addSubview(label)
        tableView.tableHeaderView = headerView
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }

}

// Mark: UITableViewDelegate
extension PokemonViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}

// Mark: UITableViewDataSource
extension PokemonViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.pokemons.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = viewModel?.pokemons[indexPath.row].name
        return cell
    }
}
