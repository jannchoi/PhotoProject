//
//  NumberFormatter.swift
//  PhotoProject
//
//  Created by 최정안 on 1/18/25.
//

import Foundation

class NumberFormatter {
    static let formatter = NumberFormatter()
    private init() { }
    
    func formatString(value: Int) -> String {
        let formatted = value.formatted()
        let result = String(formatted)
        return result
    }
}

class configString {
    static let stringToSet = configString()
    private init() { }
    
    func setSize(height: Int, width: Int) -> String {
        return "\(height) x \(width)"
    }
    
    func setStarCount(input: Int) -> String {
        return  "⭐️ " + NumberFormatter.formatter.formatString(value: input)
    }
}
