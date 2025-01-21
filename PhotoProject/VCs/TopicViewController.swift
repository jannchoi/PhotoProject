//
//  TopicViewController.swift
//  PhotoProject
//
//  Created by 최정안 on 1/17/25.
//

import UIKit
import Kingfisher

class TopicViewController: UIViewController {

    let mainView = TopicView()
    
    var firstList = [TopicPhoto]()
    var secondList = [TopicPhoto]()
    var thirdList = [TopicPhoto]()
    
    var topicList = [TopicInfo]()
    
    var quit = false
    var timer = 0
    
    override func loadView() {
        view = mainView
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        mainView.backgroundColor = .white
        getRandomTopic()
        mainView.verticalScrollView.refreshControl = UIRefreshControl()
        mainView.verticalScrollView.refreshControl?.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        
    }
    @objc
    func pullToRefresh() {
        print(#function)
        getRandomTopic()
        mainView.verticalScrollView.refreshControl?.endRefreshing()
    }
    func getRandomTopic() {
        print(#function)
        NetworkManager.shared.callRequest(api: .topicList) { (topicInfo: [TopicInfo])  in
            let shuffledList = topicInfo.shuffled()
            self.topicList.removeAll()
            self.topicList.append(contentsOf: shuffledList[0...2])
            self.loadData()
        } failHandler: {
            
        }
    }
    func loadData() {
        let group = DispatchGroup()
        
        group.enter()
        NetworkManager.shared.callRequest(api: .topicPhoto(id: topicList[0].id)) { (photo : [TopicPhoto]) in
            self.firstList = photo
            group.leave()
        } failHandler: {
            group.leave()
        }
        
        group.enter()
        NetworkManager.shared.callRequest(api: .topicPhoto(id: topicList[1].id)) { (photo : [TopicPhoto]) in
            self.secondList = photo
            group.leave()
        } failHandler: {
            group.leave()
        }
        group.enter()
        NetworkManager.shared.callRequest(api: .topicPhoto(id: topicList[2].id)) { (photo : [TopicPhoto]) in
            self.thirdList = photo
            group.leave()
        } failHandler: {
            group.leave()
        }

        group.notify(queue: .main) {
            self.setView(stackView: self.mainView.firstStackView, list: self.firstList)
            self.mainView.firstLabel.text = self.topicList[0].title
            self.setView(stackView: self.mainView.secondStackView, list: self.secondList)
            self.mainView.secondLabel.text = self.topicList[1].title
            self.setView(stackView: self.mainView.thirdStackView, list: self.thirdList)
            self.mainView.thirdLabel.text = self.topicList[2].title
        }
        
    }

    func setView(stackView: UIStackView, list: [TopicPhoto]) {
        
        for i in 0...9{
            let tempImg = stackView.arrangedSubviews[i] as! UIImageView
            let url = URL(string: list[i].urls.thumb)
            tempImg.kf.setImage(with: url)
            let tapGesture = UITapGestureRecognizer(target: self,
                                                    action: #selector(imageTapped))
            tempImg.addGestureRecognizer(tapGesture)
            tempImg.isUserInteractionEnabled = true
            
            let tempLabel = tempImg.subviews[0] as! UILabel
            tempLabel.text = configString.stringToSet.setStarCount(input: list[i].likes)
            
            DispatchQueue.main.async {
                tempLabel.layer.cornerRadius = tempLabel.frame.height / 2
                tempLabel.clipsToBounds = true
            }
        }
    }
    
    @objc
    func imageTapped(_ sender: UITapGestureRecognizer){
        let vc = PhotoDetailViewController()
        
        let targetView = sender.view as! UIImageView
        var item : TopicPhoto
        
        if targetView.tag / 10 == 0 {
            item = firstList[targetView.tag % 10]
            
        } else if targetView.tag / 10 == 1 {
            item = secondList[targetView.tag % 10]
            
        } else {
            item = thirdList[targetView.tag % 10]
        }
        vc.imageId = item.id

        let url = URL(string: item.urls.thumb)
        vc.mainView.mainImage.kf.setImage(with: url)
        vc.mainView.photoSize.text = configString.stringToSet.setSize(height: item.height, width: item.width)
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

