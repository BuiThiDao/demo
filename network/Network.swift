//
//  Network.swift
//  movie_ios
//
//  Created by user on 24/02/2023.
//

import Foundation
func getMovieRecommend(completionHandler:@escaping ([MovieRecommend]) -> Void){
    
    let url = URL(string: "\(Configs.Network.apiBaseUrl)/movie/recommendations?=1")!
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.setValue("Bearer \(Configs.Network.accessToken)", forHTTPHeaderField: "Authorization")
    
    let session = URLSession.shared
    
    
    let task = session.dataTask(with: request, completionHandler: { data, response, error in
        if (error != nil) {
            print(error!)
        } else {
            let httpResponse = response
            print(httpResponse ?? "")
            
            do {
                let model = try JSONDecoder().decode(ArrayResponse<MovieRecommend>.self, from: data!)
                completionHandler(model.results ?? [])
            } catch {
                print("Error")
            }
        }
    })
    
    task.resume()
}

// MARK: Upcoming Movies
func getUpcomingMovies(completionHandler:@escaping ([MovieRecommend]) -> Void){
    
    let url = URL(string: "\(Configs.Network.apiBaseUrl)/movie/favorites?page=1")!
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.setValue("Bearer \(Configs.Network.accessToken)", forHTTPHeaderField: "Authorization")
    
    let session = URLSession.shared
    
    
    let task = session.dataTask(with: request, completionHandler: { data, response, error in
        if (error != nil) {
            print(error!)
        } else {
            let httpResponse = response
            print(httpResponse ?? "")
            
            do {
                let model = try JSONDecoder().decode(ArrayResponse<MovieRecommend>.self, from: data!)
               
                completionHandler(model.results ?? [])
            } catch {
                print("Error ")
            }
        }
    })
    
    task.resume()
}

// MARK: Movie Detail
func getMovieDetail (movieId: Int ,completionHandler:@escaping (MovieDetail) -> Void){
   
   let url = URL(string: "\(Configs.Network.apiBaseUrlV3)/3/movie/\(movieId)?api_key=\(Configs.Network.apiKey)&language=en-US")!
   
   var request = URLRequest(url: url)
   request.httpMethod = "GET"
   request.setValue("Bearer \(Configs.Network.accessToken)", forHTTPHeaderField: "Authorization")
   
   let session = URLSession.shared
   
   
   let task = session.dataTask(with: request, completionHandler: { data, response, error in
       if (error != nil) {
           print(error!)
       } else {
           let httpResponse = response
           print(httpResponse ?? "")
           
           do {
               let model = try JSONDecoder().decode(MovieDetail.self, from: data!)
               completionHandler(model)
           } catch let error {
               print("Error Get Movie Detail \(error)")
           }
       }
   })
   
   task.resume()
}


// MARK: Movie credits
func getMovieCredits (movieId: Int ,completionHandler:@escaping (MovieCredit) -> Void){
   
    let url = URL(string: "\(Configs.Network.apiBaseUrlV3)/3/movie/\(movieId)/credits?api_key=\(Configs.Network.apiKey)&language=en-US")!
   
   var request = URLRequest(url: url)
   request.httpMethod = "GET"
   request.setValue("Bearer \(Configs.Network.accessToken)", forHTTPHeaderField: "Authorization")
   
   let session = URLSession.shared
   
   
   let task = session.dataTask(with: request, completionHandler: { data, response, error in
       if (error != nil) {
           print(error!)
       } else {
           let httpResponse = response
           print(httpResponse ?? "")
           
           do {
               let model = try JSONDecoder().decode(MovieCredit.self, from: data!)
               completionHandler(model)
           } catch {
               print("Error Get Movie Credits ")
           }
       }
   })
   
   task.resume()
}

