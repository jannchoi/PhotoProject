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
    let centerLabel = UILabel()
    
    let colorScrollView = UIScrollView()
    let colorStack = UIStackView()
    
    let colorMap: [Int: String] = [
        1: "black",
        2: "white",
        3: "yellow",
        4: "red",
        5: "purple",
        6: "green",
        7: "blue"
    ]
    
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
        addSubview(centerLabel)
        addSubview(collectionView)
        addSubview(colorScrollView)
        colorScrollView.addSubview(colorStack)
        
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
        colorScrollView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(sortSwitch)
            make.leading.equalTo(searchBar)
            make.trailing.equalTo(sortSwitch.snp.leading)
            
        }
        colorStack.snp.makeConstraints { make in
            make.edges.equalTo(colorScrollView)
            make.height.equalTo(sortSwitch)
        }
        centerLabel.snp.makeConstraints { make in
            make.center.equalTo(safeAreaLayoutGuide)
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
        centerLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
    }
    func configureColorButton() {
        
        for i in 0...7 {
            let button = UIButton()
            colorStack.addArrangedSubview(button)
            button.snp.makeConstraints { make in
                make.height.equalTo(colorStack.snp.height).inset(1)
            }
            button.tag = i
            if i == 0 {
                button.setTitle("None", for: .normal)
            }else {
                button.setTitle(colorMap[i], for: .normal)
            }
            button.setTitleColor(.black, for: .normal)
            button.backgroundColor = .systemGray6
            
        }
        colorStack.spacing = 8
    }
    
    
}

