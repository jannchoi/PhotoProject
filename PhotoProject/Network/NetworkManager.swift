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
    
    func callRequest(query: String, sort: String = "relevant", page: Int, completionHandler: @escaping (Shop) -> Void) {
        let url = "https://api.unsplash.com/search/photos?query=\(query)&page=\(page)&order_by=\(sort)&per_page=20"
        let header: HTTPHeaders = ["Authorization" : APIKey.client_id]
        AF.request(url, method: .get, headers: header)
            .responseDecodable(of: Shop.self) { response in
                switch response.result {
                case .success(let value):
                    completionHandler(value)
                case .failure(let error):
                    print(error)
                }
            }
    }
}
