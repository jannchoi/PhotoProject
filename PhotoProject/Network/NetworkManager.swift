//
//  NetworkManager.swift
//  PhotoProject
//
//  Created by 최정안 on 1/17/25.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() { }
    
    func searchPhotocallRequest(query: String, sort: String = "relevant", color: String? = nil, page: Int, completionHandler: @escaping (PhotoList) -> Void) {
        var url: String
        //URLComponents
        if let color {
            url = "https://api.unsplash.com/search/photos?query=\(query)&page=\(page)&order_by=\(sort)&per_page=20&color=\(color)"
        } else {
            url = "https://api.unsplash.com/search/photos?query=\(query)&page=\(page)&order_by=\(sort)&per_page=20"}
        
        let header: HTTPHeaders = ["Authorization" : APIKey.client_id]
        AF.request(url, method: .get, headers: header)
            .responseDecodable(of: PhotoList.self) { response in
                switch response.result {
                case .success(let value):
                    completionHandler(value)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func topicCallRequest(id: String, completionHandler: @escaping ([TopicPhoto]) -> Void) {
        let url = "https://api.unsplash.com/topics/\(id)/photos?page=1"
        let header: HTTPHeaders = ["Authorization" : APIKey.client_id]
        AF.request(url, method: .get, headers: header)
            .responseDecodable(of: [TopicPhoto].self) { response in
                switch response.result {
                case .success(let value):
                    completionHandler(value)
                case .failure(let error):
                    print(error)
                }
            }
        
    }
    func detailCallRequest(id: String, completionHandler: @escaping (DetailPhoto) -> Void) {
        let url = "https://api.unsplash.com/photos/\(id)/statistics?"
        let header: HTTPHeaders = ["Authorization" : APIKey.client_id]
        AF.request(url, method: .get, headers: header)
            .responseDecodable(of: DetailPhoto.self) { response in
                switch response.result {
                case .success(let value):
                    completionHandler(value)
                case .failure(let error):
                    print(error)
                }
            }
    }
    func topicListCallRequest(completionHandler: @escaping ([TopicInfo]) -> Void) {
        let url = "https://api.unsplash.com/topics?"
        let header: HTTPHeaders = ["Authorization" : APIKey.client_id]
        AF.request(url, method: .get, headers: header)
            .responseDecodable(of: [TopicInfo].self) { response in
                switch response.result {
                case .success(let value):
                    completionHandler(value)
                case .failure(let error):
                    print(error)
                }
            }
    }
}
