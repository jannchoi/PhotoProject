//
//  DetailPhoto.swift
//  PhotoProject
//
//  Created by 최정안 on 1/19/25.
//

import Foundation

struct DetailPhoto: Decodable {
    let id: String
    let downloads: Downloads
    let views: Views
}
struct Downloads: Decodable {
    let total: Int
}
struct Views: Decodable {
    let total: Int
}
