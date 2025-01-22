//
//  PhotoDetailViewController.swift
//  PhotoProject
//
//  Created by 최정안 on 1/18/25.
//

import UIKit
import Charts

class PhotoDetailViewController: UIViewController {

    let mainView = DetailView()
    var imageId: String?
    var imgURL: String?
    var height: Int?
    var width: Int?
    
    override func loadView() {
        view = mainView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.backgroundColor = .white
        loadData()
    }
    
    func loadData() {
        if let imageId {
            NetworkManager.shared.callRequest(api: .detail(id: imageId),model: DetailPhoto.self) {value in
                switch value {
                case .success(let data) :
                    if let result = data as? DetailPhoto{
                        self.mainView.views.text = NumberFormatter.formatter.formatString(value: result.views.total)
                        self.mainView.downloads.text = NumberFormatter.formatter.formatString(value: result.downloads.total)
                    }
                default :
                    self.showAlert(text: value.errorMessage, button: nil)
                        
                }

            } failHandler: { }
        }
        
    }

}
