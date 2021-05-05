//
//  CouncilListViewController.swift
//  StayTuneApp
//
//  Created by Rishat on 25.04.2021.
//

import UIKit

class ConcertListViewController: UIViewController, ConcertListView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private let cellId: String = "Cell"
    @IBOutlet private var collectionView: UICollectionView!
    var presenter: ConcertListPresenter?

    private var filteredConcerts = [Concert]()
    private let searchController = UISearchController(searchResultsController: nil)
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()

        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    func reloadData() {
        collectionView.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFiltering {
            return filteredConcerts.count
        }
        return presenter?.concertsCount ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? ConcertCell else {
            fatalError("Could not dequeue cell")
        }
        guard var concert = presenter?.concert(at: indexPath) else { fatalError("Could not dequeue cell") }

        if isFiltering {
            concert = filteredConcerts[indexPath.row]
        } else {
            presenter?.set(cell: cell, with: concert)
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelectConcert(at: indexPath)
    }
}

extension ConcertListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }

    private func filterContentForSearchText(_ searchText: String) {
        filteredConcerts = presenter?.getConcerts().filter({ (concert: Concert) -> Bool in
            return concert.name.lowercased().contains(searchText.lowercased())
        }) ?? []
        collectionView.reloadData()
    }
}
