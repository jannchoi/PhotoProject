//
//  Photo.swift
//  PhotoProject
//
//  Created by 최정안 on 1/18/25.
//

import Foundation

struct PhotoList: Decodable {
    let total: Int
    let results: [Photo]
}

struct Photo: Decodable {
    let id: String
    let width: Int
    let height: Int
    let urls : URLS
    let likes: Int
}
struct URLS: Decodable {
    let raw : String
}

