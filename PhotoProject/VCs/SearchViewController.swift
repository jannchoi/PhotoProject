//
//  SearchViewController.swift
//  PhotoProject
//
//  Created by 최정안 on 1/17/25.
//

import UIKit
import Kingfisher

final class SearchViewController: UIViewController {

    private let mainView = SearchView()
    
    override func loadView() {
        view = mainView
    }
    
    private var page = 1
    private var photoInfo = [Photo]()
    private var inputText = ""
    private var isEnd = false
    private var selectedSort = "relevant"
    private var selectedButtonColor : String? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainView.configureColorButton()
        mainView.backgroundColor = .white
        navigationItem.title = "Search Photo"
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.collectionView.prefetchDataSource = self
        mainView.searchBar.delegate = self
        mainView.sortSwitch.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
        mainView.centerLabel.text = "사진을 검색해보세요."
        mainView.collectionView.isHidden = true
        setColorButton()
        

    }
    func switchButtonColor(selected: Int) {
        for i in 0...7 {
            let button = mainView.colorStack.arrangedSubviews[i] as! UIButton
            if i == selected {
                button.setTitleColor(.blue, for: .normal)
                button.backgroundColor = .gray
            }
            else {
                button.setTitleColor(.black, for: .normal)
                button.backgroundColor = .systemGray6
            }
        }
    }
    
    func setColorButton() {
        for i in 0...7 {
            let button = mainView.colorStack.arrangedSubviews[i] as! UIButton
            button.addTarget(self, action: #selector(colorButton), for: .touchUpInside)
            
            DispatchQueue.main.async {
                button.layer.cornerRadius = button.frame.height / 2
                button.clipsToBounds = true
            }
            
        }
    }
    @objc
    func colorButton(_ sender: UIButton) {
        selectedButtonColor = mainView.colorMap[sender.tag] ?? nil
        loadData(query: inputText, sort: selectedSort, color: selectedButtonColor)
        switchButtonColor(selected: sender.tag)
    }
    
    func loadData(query: String, sort: String = "relevant", color: String? = nil ) {
        NetworkManager.shared.callRequest(api: .searchPhoto(query: query, sort: "relevant", color: color, page: page), model: PhotoList.self) { value in
            switch value  {
            case .success(let data) :
                    if data.results.isEmpty {
                        self.mainView.centerLabel.text = "검색 결과가 없어요."
                        self.mainView.collectionView.isHidden = true
                    }
                    if self.page == 1{
                        self.photoInfo = data.results
                    } else {
                        self.photoInfo.append(contentsOf: data.results)
                    }
                    self.photoInfo = data.results
                    if self.page * 20 >= data.total {
                        self.isEnd = true
                    }
                
                    self.mainView.collectionView.reloadData()
            default :
                self.showAlert(text: value.errorMessage, button: nil)
            }

        } failHandler: { error in
            self.showAlert(text: error, button: nil)
        }

    }
    @objc
    func switchChanged(_ sender: UISwitch) {
        if sender.isOn {
            selectedSort = "latest"
        } else {
            selectedSort = "relevant"
        }
        loadData(query: inputText, sort: selectedSort, color: selectedButtonColor)
        mainView.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
    }

}

extension SearchViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
        for item in indexPaths {
            if photoInfo.count - 4 == item.row && isEnd == false {
                page += 1
                loadData(query: inputText, sort: selectedSort, color: selectedButtonColor)
            }
        }
    }
}
extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        mainView.collectionView.isHidden = false
        let input = searchBar.text ?? ""
        let trimmedInput = input.trimmingCharacters(in: .whitespacesAndNewlines)
        
        inputText = trimmedInput
        
        loadData(query: input,sort: selectedSort, color: selectedButtonColor)

        view.endEditing(true)
        
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoInfo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchPhotoCollectionViewCell.id, for: indexPath) as! SearchPhotoCollectionViewCell

        cell.configureData(item: photoInfo[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = PhotoDetailViewController()
        let item = photoInfo[indexPath.item]
        
        vc.imageId = item.id
        let url = URL(string: item.urls.thumb)
        vc.mainView.mainImage.kf.setImage(with: url)
        vc.mainView.photoSize.text = configString.stringToSet.setSize(height: item.height, width: item.width)
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
