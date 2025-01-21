//
//  NetworkManager.swift
//  PhotoProject
//
//  Created by 최정안 on 1/17/25.
//

import Foundation
import Alamofire

enum UnsplashRequest {
    case searchPhoto(query: String, sort: String = "relevant", color: String? = nil, page: Int)
    case topicPhoto(id: String)
    case detail(id: String)
    case topicList
    
    var baseURL: String{
        return "https://api.unsplash.com/"
    }
    
    var header: HTTPHeaders {
        return ["Authorization": "Client-ID \(APIKey.client_id)"]
    }
    
    var endpoint: URL {
        switch self {
            
        case .searchPhoto(let query, let sort, let color, let page):
            if let color {
                return URL(string: baseURL + "search/photos?query=\(query)&page=\(page)&order_by=\(sort)&per_page=20&color=\(color)")!
            } else {
                return URL(string: baseURL + "search/photos?query=\(query)&page=\(page)&order_by=\(sort)&per_page=20")!
            }
        case .topicPhoto(let id):
            return URL(string: baseURL + "topics/\(id)/photos?page=1")!
        case .detail(let id):
            return URL(string: baseURL + "photos/\(id)/statistics?")!
        case .topicList:
            return URL(string: baseURL + "topics?")!
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
}

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() { }
    
    
    func callRequest<T: Decodable>(api: UnsplashRequest, completionHandler: @escaping(T) -> Void, failHandler: @escaping () ->Void) {
        AF.request(api.endpoint, method: api.method, headers: api.header)
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    completionHandler(value)
                case .failure(let error):
                    print(error)
                    failHandler()
                }
            }
    }
    
//    func searchPhotocallRequest(query: String, sort: String = "relevant", color: String? = nil, page: Int, completionHandler: @escaping (PhotoList) -> Void) {
//        var url: String
//        //URLComponents
//        if let color {
//            url = "https://api.unsplash.com/search/photos?query=\(query)&page=\(page)&order_by=\(sort)&per_page=20&color=\(color)"
//        } else {
//            url = "https://api.unsplash.com/search/photos?query=\(query)&page=\(page)&order_by=\(sort)&per_page=20"}
//        
//        let header: HTTPHeaders = ["Authorization" : APIKey.client_id]
//        AF.request(url, method: .get, headers: header)
//            .responseDecodable(of: PhotoList.self) { response in
//                switch response.result {
//                case .success(let value):
//                    completionHandler(value)
//                case .failure(let error):
//                    print(error)
//                }
//            }
//    }
//    
//    func topicCallRequest(id: String, completionHandler: @escaping ([TopicPhoto]) -> Void) {
//        let url = "https://api.unsplash.com/topics/\(id)/photos?page=1"
//        let header: HTTPHeaders = ["Authorization" : APIKey.client_id]
//        AF.request(url, method: .get, headers: header)
//            .responseDecodable(of: [TopicPhoto].self) { response in
//                switch response.result {
//                case .success(let value):
//                    completionHandler(value)
//                case .failure(let error):
//                    print(error)
//                }
//            }
//        
//    }
//    func detailCallRequest(id: String, completionHandler: @escaping (DetailPhoto) -> Void) {
//        let url = "https://api.unsplash.com/photos/\(id)/statistics?"
//        let header: HTTPHeaders = ["Authorization" : APIKey.client_id]
//        AF.request(url, method: .get, headers: header)
//            .responseDecodable(of: DetailPhoto.self) { response in
//                switch response.result {
//                case .success(let value):
//                    completionHandler(value)
//                case .failure(let error):
//                    print(error)
//                }
//            }
//    }
//    func topicListCallRequest(completionHandler: @escaping ([TopicInfo]) -> Void) {
//        let url = "https://api.unsplash.com/topics?"
//        let header: HTTPHeaders = ["Authorization" : APIKey.client_id]
//        AF.request(url, method: .get, headers: header)
//            .responseDecodable(of: [TopicInfo].self) { response in
//                switch response.result {
//                case .success(let value):
//                    completionHandler(value)
//                case .failure(let error):
//                    print(error)
//                }
//            }
//    }
}
