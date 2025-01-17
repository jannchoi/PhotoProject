//
//  SearchView.swift
//  PhotoProject
//
//  Created by 최정안 on 1/17/25.
//

import UIKit
import SnapKit

class SearchView: BaseView {
    lazy var  collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
    
    let searchBar = UISearchBar()
    let sortSwitch = UISwitch()
    
    
    func createCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let sectionInset: CGFloat = 4
        let cellSpacing: CGFloat = 4
        let ColViewWidth:CGFloat = UIScreen.main.bounds.width - 24
        let cellWidth = ColViewWidth - (sectionInset * 2) - (cellSpacing *  1)
        layout.itemSize = CGSize(width: cellWidth / 2, height: cellWidth / 3 * 2)
        layout.sectionInset = UIEdgeInsets(top: 0, left: sectionInset, bottom: 0, right: sectionInset)
        return layout
    }

    override func configureHierachy() {
        addSubview(searchBar)
        addSubview(sortSwitch)
        addSubview(collectionView)
    }
    override func configureLayout() {
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(8)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(8)
            make.centerX.equalToSuperview()
        }
        sortSwitch.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(8)
            make.trailing.equalTo(safeAreaLayoutGuide).inset(8)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(sortSwitch.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(8)
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    override func configureView() {
        searchBar.placeholder = "키워드 검색"
        collectionView.register(SearchPhotoCollectionViewCell.self, forCellWithReuseIdentifier: SearchPhotoCollectionViewCell.id)
        collectionView.backgroundColor = .gray
    }
    
    
}
