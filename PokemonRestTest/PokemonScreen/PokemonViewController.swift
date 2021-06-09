//
//  ViewController.swift
//  PokemonRestTest
//
//  Created by Viacheslav Markov on 30.05.2021.
//

import UIKit

class PokemonViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pageControl: UIPageControl!
    var currentPage: Int = 0
    
    var viewModel: PokemonViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupHeaderTableView()
        setupTableView()
        currentPage = pageControl.currentPage
        viewModel = PokemonViewModel()
        
        update()

        viewModel?.getPokemon()
        
        pageControl.addTarget(self, action: #selector(self.pageControlDidTapped(_:)), for: .valueChanged)
    }
    
    @objc
    func pageControlDidTapped(_ sender: UIPageControl) {
        let urlString = ((currentPage - sender.currentPage) > 0)
            ? viewModel?.previousPageURLString
            : viewModel?.nextPageURLString
        
        viewModel?.getPokemon(with: urlString)
        currentPage = sender.currentPage
    }
    
    private func update() {
        viewModel?.subscribe { error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            self.tableView.reloadData()
        }
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

// MARK: - UITableViewDelegate
extension PokemonViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let showStoryboard = UIStoryboard.init(name: "Show", bundle: nil)
        guard let showViewController = showStoryboard.instantiateViewController(identifier: "ShowViewController") as? ShowViewController else { return }
        let showViewModel = ShowViewModel(data: viewModel?.cach[indexPath.row] ?? Data(),
                                          name: viewModel?.pokemons[indexPath.row].name ?? "",
                                          number: viewModel?.getNumberPokemon(at: indexPath.row) ?? 0)
        showViewController.viewModel = showViewModel
        present(showViewController, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension PokemonViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.pokemons.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = viewModel?.pokemons[indexPath.row].name
        cell.imageView?.image = UIImage(named: "defaultPokemon")
        
        DispatchQueue.main.async {
            self.viewModel?.fetchImagePokemon(at: indexPath.row, comletion: { data in
                cell.imageView?.image = UIImage(data: data)
            })
        }
        return cell
    }
}
