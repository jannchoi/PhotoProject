//
//  TopicViewController.swift
//  PhotoProject
//
//  Created by 최정안 on 1/17/25.
//

import UIKit
import Kingfisher

final class TopicViewController: UIViewController {

    private let mainView = TopicView()
    
    private var firstList = [Photo]()
    private var secondList = [Photo]()
    private var thirdList = [Photo]()
    
    private var topicList = [TopicInfo]()
    
    private var quit = false
    
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
        NetworkManager.shared.callRequest(api: .topicList, model: [TopicInfo].self) { value  in
            switch value {
            case .success(let data) :
                    let shuffledList = data.shuffled()
                    self.topicList.removeAll()
                    self.topicList.append(contentsOf: shuffledList[0...2])
                    self.loadData()
            default:
                self.showAlert(text: value.errorMessage, button: nil)
            }

        } failHandler: { error in
            self.showAlert(text: error, button: nil)
            
        }

    }
    
    func loadData() {
        let group = DispatchGroup()
        
        group.enter()
        NetworkManager.shared.callRequest(api: .topicPhoto(id: topicList[0].id), model: [Photo].self) { value in
            switch value {
            case .success(let data) :
                    self.firstList = data
            default :
                self.showAlert(text: value.errorMessage, button: nil)
            }
            group.leave()
        } failHandler: { error in
            self.showAlert(text: error, button: nil)
            group.leave()
        }
        
        group.enter()
        NetworkManager.shared.callRequest(api: .topicPhoto(id: topicList[1].id), model: [Photo].self) { value in
            switch value {
            case .success(let data) :
                    self.secondList = data
            default :
                self.showAlert(text: value.errorMessage, button: nil)
            }
            group.leave()
        } failHandler: { error in
            self.showAlert(text: error, button: nil)
            group.leave()
        }
        group.enter()
        NetworkManager.shared.callRequest(api: .topicPhoto(id: topicList[2].id), model: [Photo].self) { value in
            switch value {
            case .success(let data) :
                    self.thirdList = data
            default :
                self.showAlert(text: value.errorMessage, button: nil)
            }
            group.leave()
        } failHandler: { error in
            self.showAlert(text: error, button: nil)
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

    func setView(stackView: UIStackView, list: [Photo]) {
        
        for i in 0...9{
            let group = DispatchGroup()
            group.enter()
            let tempImg = stackView.arrangedSubviews[i] as! UIImageView
            let url = URL(string: list[i].urls.thumb)
            tempImg.kf.setImage(with: url)
            group.leave()
            
            group.notify(queue: .main) {
                let tapGesture = UITapGestureRecognizer(target: self,
                                                        action: #selector(self.imageTapped))
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
    }
    
    @objc
    func imageTapped(_ sender: UITapGestureRecognizer){
        let vc = PhotoDetailViewController()
        
        let targetView = sender.view as! UIImageView
        var item : Photo
        
        if targetView.tag / 10 == 0 {
            item = firstList[targetView.tag % 10]
            
        } else if targetView.tag / 10 == 1 {
            item = secondList[targetView.tag % 10]
            
        } else {
            item = thirdList[targetView.tag % 10]
        }
        vc.viewModel.input.topicPhoto.value = item
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension UIViewController  {
    func showAlert(text: String, button: String?,  action: (() -> Void)? = nil) {
    
        let alert = UIAlertController(title: "알림", message: text, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .default)
        if let action {
            let button = UIAlertAction(title: button ?? "버튼", style: .default) { _ in
                action()
            }
            alert.addAction(button)
            
        }
        alert.addAction(cancel)
        present(alert, animated: true)
    }
}
