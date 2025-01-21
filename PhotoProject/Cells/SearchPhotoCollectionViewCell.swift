//
//  SearchPhotoCollectionViewCell.swift
//  PhotoProject
//
//  Created by 최정안 on 1/17/25.
//

import UIKit
import Kingfisher
import SnapKit

class SearchPhotoCollectionViewCell: BaseCollectionViewCell {
    
    
    static let id = "SearchPhotoCollectionViewCell"
    
    let itemImage = UIImageView()
    let starCount = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    func configureData(item: Photo) {
        let url = URL(string: item.urls.thumb)
        itemImage.kf.setImage(with: url)
        starCount.text = configString.stringToSet.setStarCount(input: item.likes)
        
    }
    override func configureHierachy() {
        contentView.addSubview(itemImage)
        contentView.addSubview(starCount)
        
    }
    override func configureLayout() {
        itemImage.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.size.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        starCount.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview().inset(8)
        }
    }
    override func configureView() {
        itemImage.contentMode = .scaleToFill
        
        starCount.textColor = .white
        starCount.font = UIFont.systemFont(ofSize: 12)
        starCount.textAlignment = .center
        starCount.backgroundColor = .gray
        
        DispatchQueue.main.async {
            self.starCount.layer.cornerRadius = self.starCount.frame.height / 2
            self.starCount.clipsToBounds = true
        }
        
    }
    
}

