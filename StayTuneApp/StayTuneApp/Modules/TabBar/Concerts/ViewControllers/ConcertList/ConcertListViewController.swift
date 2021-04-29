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

    let searchController = UISearchController(searchResultsController: nil)

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
        presenter?.memberCount ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? ConcertMemberCell else {
            fatalError("Could not dequeue cell")
        }
        guard let member = presenter?.member(at: indexPath) else { fatalError("Could not dequeue cell") }
        presenter?.set(cell: cell, with: member)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelectMember(at: indexPath)
    }
}

extension ConcertListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {

    }
}
