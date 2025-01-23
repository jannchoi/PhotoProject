//
//  TopicView.swift
//  PhotoProject
//
//  Created by 최정안 on 1/18/25.
//

import UIKit
import SnapKit


class TopicView: BaseView {
    let verticalScrollView = UIScrollView()
    
    let mainLabel = UILabel()
    
    let firstLabel = UILabel()
    private let firstScrollView = UIScrollView()
    let firstStackView = UIStackView()
    
    let secondLabel = UILabel()
    private let secondScrollView = UIScrollView()
    let secondStackView = UIStackView()
    
    let thirdLabel = UILabel()
    private let thirdScrollView = UIScrollView()
    let thirdStackView = UIStackView()
    
    
    override func configureHierachy() {
        addSubview(mainLabel)
        addSubview(verticalScrollView)
        verticalScrollView.addSubview(firstLabel)
        verticalScrollView.addSubview(firstScrollView)
        firstScrollView.addSubview(firstStackView)
        verticalScrollView.addSubview(secondLabel)
        verticalScrollView.addSubview(secondScrollView)
        secondScrollView.addSubview(secondStackView)
        verticalScrollView.addSubview(thirdLabel)
        verticalScrollView.addSubview(thirdScrollView)
        thirdScrollView.addSubview(thirdStackView)
    }
    
    override func configureLayout() {
        mainLabel.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(safeAreaLayoutGuide).inset(10)
            make.height.equalTo(40)
        }
        verticalScrollView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide).inset(10)
            make.top.equalTo(mainLabel.snp.bottom)
        }

        firstLabel.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(verticalScrollView)
            make.height.equalTo(21)
        }
        firstScrollView.snp.makeConstraints { make in
            make.top.equalTo(firstLabel.snp.bottom).offset(8)
            make.height.equalTo(200)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(10)
        }
        firstStackView.snp.makeConstraints { make in
            make.edges.equalTo(firstScrollView)
            make.height.equalTo(200)
        }
        
        secondLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(verticalScrollView)
            make.top.equalTo(firstScrollView.snp.bottom).offset(8)
            make.height.equalTo(21)
        }
        secondScrollView.snp.makeConstraints { make in
            make.top.equalTo(secondLabel.snp.bottom).offset(8)
            make.height.equalTo(200)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(10)
        }
        secondStackView.snp.makeConstraints { make in
            make.edges.equalTo(secondScrollView)
            make.height.equalTo(200)
        }
        
        thirdLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(verticalScrollView)
            make.top.equalTo(secondScrollView.snp.bottom).offset(8)
            make.height.equalTo(21)
        }
        thirdScrollView.snp.makeConstraints { make in
            make.top.equalTo(thirdLabel.snp.bottom).offset(8)
            make.height.equalTo(200)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(10)
            make.bottom.equalToSuperview() //*
        }
        thirdStackView.snp.makeConstraints { make in
            make.edges.equalTo(thirdScrollView)
            make.height.equalTo(200)
        }
        
    }
    override func configureView() {
        mainLabel.text = "OUR TOPIC"
        mainLabel.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        
        firstLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        
        secondLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        
        thirdLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        
        configureStackView(stackView: firstStackView, startTag: 0)
        configureStackView(stackView: secondStackView, startTag: 10)
        configureStackView(stackView: thirdStackView, startTag: 20)
        
    }
    
    func configureStackView(stackView: UIStackView, startTag: Int) {
        
        for i in 0...9 {
            let img = UIImageView()
            stackView.addArrangedSubview(img)
            
            img.snp.makeConstraints { make in
                make.width.equalTo(200 / 4 * 3)
                make.height.equalTo(200)
            }
            img.tag = startTag + i
            img.layer.cornerRadius = 8
            img.clipsToBounds = true
            let label = UILabel()
            img.addSubview(label)
            label.snp.makeConstraints { make in
                make.leading.bottom.equalToSuperview().inset(8)
            }
            label.textColor = .white
            label.font = UIFont.systemFont(ofSize: 12)
            label.textAlignment = .center
            label.backgroundColor = .gray

        }
        stackView.spacing = 4

    }
}
