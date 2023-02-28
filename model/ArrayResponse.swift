//
//  ArrayResponse.swift
//  movie_ios
//
//  Created by user on 24/02/2023.
//

import Foundation
struct ArrayResponse<T: Codable>: Codable {
    var page: Int?
    var totalReseult: Int?
    var totalPage: Int?
    var results: [T]?

    
    
    enum CodingKeys: String, CodingKey {
        case page = "page"
        case totalReseult = "total_results"
        case totalPage = "total_pages"
        case results = "results"
    }

}
