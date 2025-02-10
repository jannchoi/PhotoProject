//
//  PhotoDetailViewController.swift
//  PhotoProject
//
//  Created by 최정안 on 1/18/25.
//

import UIKit
import Kingfisher


final class PhotoDetailViewController: UIViewController {

    let mainView = DetailView()
    let viewModel = PhotoDetailViewModel()
    
    override func loadView() {
        view = mainView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.backgroundColor = .white
        bindData()
        

    }
    func bindData() {
        
        viewModel.output.photosize.lazyBind { text in
            guard let text else {return}
            self.mainView.photoSize.text = text
        }

        viewModel.output.imageURL.bind { url in
            guard let url else {return}
            self.mainView.mainImage.kf.setImage(with: url)
        }
        
        viewModel.output.viewTotal.lazyBind { text in
            guard let text else {return}
            self.mainView.views.text = text
        }
        viewModel.output.downloads.lazyBind { text in
            guard let text else {return}
            self.mainView.downloads.text = text
        }
        viewModel.output.errorMessage.lazyBind { message in
            self.showAlert(text: message, button: nil)
        }
        
    }
    

}
