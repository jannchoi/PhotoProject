//
//  SearchViewController.swift
//  PhotoProject
//
//  Created by 최정안 on 1/17/25.
//

import UIKit

class SearchViewController: UIViewController {

    let mainView = SearchView()
    override func loadView() {
        view = mainView
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        mainView.backgroundColor = .white
        navigationItem.title = "Search Photo"
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.searchBar.delegate = self
    }

}
extension SearchViewController: UISearchBarDelegate {
    
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchPhotoCollectionViewCell.id, for: indexPath) as! SearchPhotoCollectionViewCell
        
        cell.backgroundColor = .blue
        return cell
    }
    
    
}
