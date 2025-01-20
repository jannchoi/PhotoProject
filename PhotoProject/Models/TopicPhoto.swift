//
//  TopicPhoto.swift
//  PhotoProject
//
//  Created by 최정안 on 1/18/25.
//

import Foundation


struct TopicPhoto: Decodable {
    let id: String
    let width: Int
    let height: Int
    let urls: Urls
    let likes: Int
}

struct Urls: Decodable {
    let raw: String
}

struct TopicInfo: Decodable {
    let id: String
    let title: String
}
