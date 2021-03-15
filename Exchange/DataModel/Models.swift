//
//  Models.swift
//  Exchange
//
//  Created by Mac on 2021/03/15.
//

import Foundation

struct Result:Codable {
    let data: [ResultItem]
}

struct ResultItem:Codable {
    let currency: String
    let buyCourse: Int
    let sellCourse: Int
}
