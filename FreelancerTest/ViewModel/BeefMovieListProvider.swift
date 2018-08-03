//
//  BeefMovieListProvider.swift
//  FreelancerTest
//
//  Created by Christian John Lo on 02/08/2018.
//  Copyright © 2018 Christian John Lo. All rights reserved.
//

import Foundation
import Alamofire

class BeefMovieListProvider : MovieListProvider {
    var delegate: MovieListProviderDelegate?
    private var movieList : [DisplayableMovie] = []
    private let beefURL = "https://www.whatsbeef.net/wabz/guide.php"
    
    func getMovieCount() -> Int {
        return movieList.count
    }
    
    func getMovie(atIndex: Int) -> DisplayableMovie? {
        if movieList.count > atIndex {
            return movieList[atIndex]
        }
        else {
            return nil
        }
    }
    
    func loadMoreMovies() {
        // Get next batch of movies from whatsbeef
        let params : Parameters = ["start" : movieList.count]
        Alamofire.request(beefURL, parameters: params).validate().responseData { response in
            
            if let jsonData = response.result.value {
                
                let jsonDecoder = JSONDecoder()
                
                do {
                    let response : MovieBeefGuideResponse = try jsonDecoder.decode(MovieBeefGuideResponse.self, from: jsonData)
                    
                    let currentCount = self.movieList.count
                    
                    for beefMovie in response.results {
                        self.movieList.append(Movie(movieTitle: beefMovie.name, movieTimeslot: "\(beefMovie.start_time) - \(beefMovie.end_time)", movieChannel: Channel(withRawValue: beefMovie.channel), movieRating: Rating(withRawValue: beefMovie.rating)))
                    }
                    
                    let lastCount = self.movieList.count
                    
                    self.delegate?.movieListProvider(self, addedMoviesWithRange: currentCount..<lastCount)
                    
                }
                catch {
                    // can't decode
                }
            }
        }
    }
}

struct MovieBeefMovie: Decodable {
    var name : String
    var start_time : String
    var end_time : String
    var rating : String
    var channel : String
}

struct MovieBeefGuideResponse: Decodable {
    var count : Int
    var results : [MovieBeefMovie]
}
