//
//  MovieRecommend.swift
//  movie_ios
//
//  Created by user on 24/02/2023.
//

import Foundation

struct MovieRecommend: Codable {
    var id: Int?
    var featured: String?
    var description: String?
    var name: String?
    var averageRating: String?
    var posterPath: String?
    var overview: String?
    
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case featured = "featured"
        case description = "description"
        case name = "title"
        case averageRating = "average_rating"
        case posterPath = "poster_path"
        case overview = "overview"
    }

}
