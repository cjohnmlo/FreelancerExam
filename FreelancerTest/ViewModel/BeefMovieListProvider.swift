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
        let params : Parameters = ["start" : movieList.count]
        Alamofire.request(beefURL, parameters: params).validate().responseJSON { response in
            
            if let json = response.result.value {
                let jsonDict = json as! Dictionary<String, Any>
                
                if let results = jsonDict["results"] {
                    let resultArray = results as! Array<Dictionary<String, Any>>
                    
                    let currentCount = self.movieList.count
                    
                    for movieJson in resultArray {
                    
                        let title = movieJson["name"] as! String
                        let startTime = movieJson["start_time"] as! String
                        let endTime = movieJson["end_time"] as! String
                        let rating = movieJson["rating"] as! String
                        let channel = movieJson["channel"] as! String
                        self.movieList.append(Movie(movieTitle: title, movieTimeslot: "\(startTime) - \(endTime)", movieChannel: Channel(withRawValue: channel), movieRating: Rating(withRawValue: rating)))
                    }
                    
                    let lastCount = self.movieList.count

                    self.delegate?.movieListProvider(self, addedMoviesWithRange: currentCount..<lastCount)
                }
            }
        }
    }
}
