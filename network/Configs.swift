//
//  Configs.swift
//  movie_ios
//
//  Created by user on 24/02/2023.
//

import Foundation
struct Configs {
    struct App {
        static let bundleIdentifier = "thoson.it"
    }
    
    struct Network {
        static let apiBaseUrlV3 = "https://api.themoviedb.org/"
        static let apiBaseUrl = "https://api.themoviedb.org/4/account/63f45deba24c5000d4e500ca"
        static let accountId = "63f45deba24c5000d4e500ca"
        static let accessToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJqdGkiOiI1NjMzMDk5Iiwic2NvcGVzIjpbImFwaV9yZWFkIiwiYXBpX3dyaXRlIl0sInN1YiI6IjYzZjQ1ZGViYTI0YzUwMDBkNGU1MDBjYSIsInZlcnNpb24iOjEsIm5iZiI6MTY3NzI0NzE4MSwiYXVkIjoiYTI2NDA2YTBmYmNiMjRlOTg3Y2M2ZTg5NWY2Zjk2ZjgifQ.G0ix8gD-VlcMmvyrI-GQkfELVJCDOSyibUlKLgZXWCo"
        static let baseImageUrl = "https://image.tmdb.org/t/p/original"
        static let apiKey = "a26406a0fbcb24e987cc6e895f6f96f8"
    }
}
