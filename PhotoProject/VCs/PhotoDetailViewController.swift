//
//  PhotoDetailViewController.swift
//  PhotoProject
//
//  Created by 최정안 on 1/18/25.
//

import UIKit

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
            NetworkManager.shared.callRequest(api: .detail(id: imageId)) { (value: DetailPhoto) in
                self.mainView.views.text = NumberFormatter.formatter.formatString(value: value.views.total)
                self.mainView.downloads.text = NumberFormatter.formatter.formatString(value: value.downloads.total)
            } failHandler: { }
        }
        
    }

}
