//
//  PhotoDetailViewModel.swift
//  PhotoProject
//
//  Created by 최정안 on 2/10/25.
//

import Foundation

final class PhotoDetailViewModel: BaseViewModel {
    
    private(set) var input: Input
    private(set) var output: Output
    
    struct Input {
        var imageID: Observable<String?> = Observable(nil)
        var topicPhoto: Observable<Photo?> = Observable(nil)
        
    }
    struct Output {
        var errorMessage: Observable<String> = Observable("")
        
        var viewTotal: Observable<String?> = Observable(nil)
        var downloads: Observable<String?> = Observable(nil)
        
        var imageURL: Observable<URL?> = Observable(nil)
        var photosize: Observable<String?> = Observable("")
    }


    
    init() {
        print("PhotoDetailviewModel init")
        input = Input()
        output = Output()
        
        transform()
    }
    
    func transform() {
        input.topicPhoto.bind { data in
            guard let data else {return}
            self.input.imageID.value = data.id
            self.output.imageURL.value = URL(string: data.urls.thumb)
            self.output.photosize.value = configString.stringToSet.setSize(height: data.height, width: data.width)
            
        }
        input.imageID.bind { _ in
            self.loadData()
        }
        
    }
    
    private func loadData() {
        if let imageid = input.imageID.value {
            NetworkManager.shared.callRequest(api: .detail(id: imageid), model: DetailPhoto.self) {value in
                switch value {
                case .success(let data) :
                    self.output.viewTotal.value = self.numberFormat(data.views.total)
                    self.output.downloads.value = self.numberFormat(data.downloads.total)
                default :
                    self.output.errorMessage.value = value.errorMessage
                }
            } failHandler: { error in
                self.output.errorMessage.value = error
            }
        }
        
    }
    private func numberFormat(_ input: Int) -> String {
        return NumberFormatter.formatter.formatString(value: input)
    }
    
    
}
