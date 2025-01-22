//
//  NetworkManager.swift
//  PhotoProject
//
//  Created by 최정안 on 1/17/25.
//

import UIKit
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

enum NetworkResult<T> {
    case success(data: T)
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case otherError
    
    var errorMessage : String {
        switch self {
        case .success : return "Success"
        case .badRequest : return "The request was unacceptable, often due to missing a required parameter"
        case .unauthorized : return "Invalid Access Token"
        case .forbidden : return "Missing permissions to perform request"
        case .notFound : return "The requested resource doesn’t exist"
        default : return "Something wrong.."
        }
    }
}

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() { }
    
    
    func callRequest<T: Decodable>(api: UnsplashRequest,model: T.Type, completionHandler: @escaping(NetworkResult<Any>) -> Void, failHandler: @escaping () ->Void) {
        AF.request(api.endpoint, method: api.method, headers: api.header)
            .validate(statusCode: 200..<500)
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    guard let statusCode = response.response?.statusCode else {return}
                    let result = self.defineStatus(statusCode: statusCode, data: value)
                    completionHandler(result)
                case .failure(let error):
                    print(error)
                    
                    failHandler()
                }
            }
    }
    
    func defineStatus<T: Decodable>(statusCode: Int,data: T) -> NetworkResult<Any> {
        switch statusCode {
        case 200 : return .success(data: data)
        case 400 : return .badRequest
        case 401 : return .unauthorized
        case 403 : return .forbidden
        case 404 : return .notFound
        default:
            return .otherError
        }
    }
    
}
