//
//  DetailView.swift
//  PhotoProject
//
//  Created by 최정안 on 1/18/25.
//

import UIKit
import SnapKit

class DetailView: BaseView {
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    let mainImage = UIImageView()
    let infoLabel = UILabel()
    let sizeLabel = UILabel()
    let photoSize = UILabel()
    let viewsLabel = UILabel()
    let views = UILabel()
    let downloadsLabel = UILabel()
    let downloads = UILabel()
    
    
    override func configureHierachy() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(mainImage)
        contentView.addSubview(infoLabel)
        contentView.addSubview(sizeLabel)
        contentView.addSubview(photoSize)
        contentView.addSubview(viewsLabel)
        contentView.addSubview(views)
        contentView.addSubview(downloadsLabel)
        contentView.addSubview(downloads)
    }
    override func configureLayout() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.width.equalTo(scrollView.snp.width)
            make.verticalEdges.equalTo(scrollView)
        }
        mainImage.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(contentView).inset(4)
            make.height.equalTo(700)
        }
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(mainImage.snp.bottom).offset(16)
            make.leading.equalTo(contentView).inset(16)
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
        sizeLabel.snp.makeConstraints { make in
            make.leading.equalTo(infoLabel.snp.trailing)
            make.top.equalTo(infoLabel)
            make.height.equalTo(30)
        }
        photoSize.snp.makeConstraints { make in
            make.trailing.equalTo(contentView).inset(16)
            make.centerY.equalTo(sizeLabel)
            make.height.equalTo(30)
        }
        viewsLabel.snp.makeConstraints { make in
            make.leading.equalTo(infoLabel.snp.trailing)
            make.top.equalTo(sizeLabel.snp.bottom)
            make.height.equalTo(30)
        }
        views.snp.makeConstraints { make in
            make.trailing.equalTo(contentView).inset(16)
            make.centerY.equalTo(viewsLabel)
            make.height.equalTo(30)
        }
        downloadsLabel.snp.makeConstraints { make in
            make.leading.equalTo(infoLabel.snp.trailing)
            make.top.equalTo(viewsLabel.snp.bottom)
            make.height.equalTo(30)
        }
        downloads.snp.makeConstraints { make in
            make.trailing.equalTo(contentView).inset(16)
            make.centerY.equalTo(downloadsLabel)
            make.height.equalTo(30)
            make.bottom.greaterThanOrEqualTo(contentView.snp.bottom)
        }
        
        
    }
    override func configureView() {
        
        mainImage.image = UIImage(systemName: "star")
        
        labelDesign(label: infoLabel,text: "정보", size: 14, weight: .bold)
        labelDesign(label: sizeLabel,text: "크기", size: 14, weight: .bold)
        labelDesign(label: viewsLabel,text: "조회수", size: 14, weight: .bold)
        labelDesign(label: downloadsLabel,text: "다운로드", size: 14, weight: .bold)
        labelDesign(label: photoSize, size: 12, color: .gray)
        labelDesign(label: views, size: 12, color: .gray)
        labelDesign(label: downloads, size: 12, color: .gray)

    }
    func labelDesign(label: UILabel,text: String = "", size: CGFloat, weight: UIFont.Weight = .regular, color: UIColor = .black) {
        label.text = text
        label.font = UIFont.systemFont(ofSize: size, weight: weight)
        label.textColor = color
    }
}
