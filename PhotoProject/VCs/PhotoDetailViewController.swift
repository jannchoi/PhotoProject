//
//  PhotoDetailViewController.swift
//  PhotoProject
//
//  Created by 최정안 on 1/18/25.
//

import UIKit
import Charts

final class PhotoDetailViewController: UIViewController {

    let mainView = DetailView()
    var imageId: String?
    private var imgURL: String?
    private var height: Int?
    private var width: Int?
    
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
            NetworkManager.shared.callRequest(api: .detail(id: imageId), model: DetailPhoto.self) {value in
                switch value {
                case .success(let data) :
                        self.mainView.views.text = NumberFormatter.formatter.formatString(value: data.views.total)
                        self.mainView.downloads.text = NumberFormatter.formatter.formatString(value: data.downloads.total)
                default :
                    self.showAlert(text: value.errorMessage, button: nil)
                }
            } failHandler: { error in
                self.showAlert(text: error, button: nil)
            }
        }
        
    }

}
