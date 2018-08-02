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
        
        Alamofire.request(baseURL, parameters: params).validate().responseJSON { response in
            
            if let json = response.result.value {
                let jsonDict = json as! Dictionary<String, Any>
                
                if let results = jsonDict["results"] {
                    
                    let resultArray = results as! Array<Dictionary<String, Any>>
                    if resultArray.count > 0 {
                        let movieDetails = resultArray[0]
                    
                        if let overview = movieDetails["overview"] as? String {
                            self.movieSummary.next(overview)
                        }
                        
                        if let backdrop = movieDetails["backdrop_path"] as? String {
                            self.moviePosterURL.next(URL(string: "\(self.imageSourceURL)\(backdrop)"))
                        }
                        else {
                            if let poster = movieDetails["poster_path"] as? String {
                                self.moviePosterURL.next(URL(string: "\(self.imageSourceURL)\(poster)"))
                            }
                        }
                    }
                }
            }
        }
    }
    
}
