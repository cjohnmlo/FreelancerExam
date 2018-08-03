//
//  MovieDBMovieSummaryViewModel.swift
//  FreelancerTest
//
//  Created by Christian John Lo on 02/08/2018.
//  Copyright © 2018 Christian John Lo. All rights reserved.
//
// https://image.tmdb.org/t/p/w500

import Foundation
import Alamofire
import Bond

class MovieDBMovieSummaryViewModel : DisplayableMovieSummary {
    
    var displayableMovie: DisplayableMovie
    var movieSummary: Observable<String?>
    var moviePosterURL: Observable<URL?>
    
    private let baseURL = "https://api.themoviedb.org/3/search/tv"
    private let imageSourceURL = "https://image.tmdb.org/t/p/w780"
    
    init(movieDetails: DisplayableMovie) {
        self.displayableMovie = movieDetails
        
        self.movieSummary = Observable<String?>("")
        self.moviePosterURL = Observable<URL?>(URL(string: ""))
        
        self.searchMovie()
    }
    
    private func searchMovie() {
        
        let params : Parameters = ["api_key" : "2093ce03b15202005d2837658657ae2f", "query" : self.displayableMovie.movieTitle]
        
        Alamofire.request(baseURL, parameters: params).validate().responseData { response in
            
            if let jsonData = response.result.value {
               
                let jsonDecoder = JSONDecoder()
                
                do {
                    let response : MovieDBResponse = try jsonDecoder.decode(MovieDBResponse.self, from: jsonData)
                    
                    if response.results.count > 0 {
                        let showDetail : MovieDBShowDetail = response.results[0]
                        self.movieSummary.next(showDetail.overview)
                        
                        if let backdrop = showDetail.backdrop_path {
                            self.moviePosterURL.next(URL(string: "\(self.imageSourceURL)\(backdrop)"))
                        }
                        else if let poster = showDetail.poster_path {
                            self.moviePosterURL.next(URL(string: "\(self.imageSourceURL)\(poster)"))
                        }
                        
                    }
                    
                }
                catch {
                    // can't decode
                }
            }
        }
    }
}

struct MovieDBShowDetail: Decodable {
    var overview : String
    var backdrop_path : String?
    var poster_path : String?
}

struct MovieDBResponse: Decodable {
    var results : [MovieDBShowDetail]
    var page : Int
    var total_results : Int
    var total_pages : Int
}
