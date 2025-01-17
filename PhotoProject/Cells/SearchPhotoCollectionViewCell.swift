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
//    func configureData(item: itemDetail) {
//        let url = URL(string: item.image)
//        itemImage.kf.setImage(with: url)
//        
//    }
    override func configureHierachy() {
        contentView.addSubview(itemImage)
        contentView.addSubview(starCount)
        
    }
    override func configureLayout() {
        itemImage.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(self.snp.width)
            make.centerX.equalToSuperview()
        }
        starCount.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview().inset(8)
        }
    }
    override func configureView() {
        itemImage.layer.cornerRadius = 8
        itemImage.clipsToBounds = true
        
        starCount.textColor = .white
        starCount.font = UIFont.systemFont(ofSize: 12)
        starCount.textAlignment = .center
        starCount.backgroundColor = .gray
        starCount.layer.cornerRadius = starCount.frame.height / 2
        starCount.clipsToBounds = true
        
    }
    
}

