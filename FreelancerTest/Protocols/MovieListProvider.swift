//
//  MovieListProvider.swift
//  FreelancerTest
//
//  Created by Christian John Lo on 31/07/2018.
//  Copyright © 2018 Christian John Lo. All rights reserved.
//

protocol MovieListProvider {
    func getMovieCount() -> Int
    func getMovie(atIndex: Int) -> DisplayableMovie
}

extension MovieListProvider {
    func getMovieCount() -> Int {
        return 5
    }
    
    func getMovie(atIndex: Int) -> DisplayableMovie {
        return Movie(movieTitle: "Twilight Long Twilight Long Twilight Long Twilight Long Twilight Long Twilight Long Twilight Long Twilight Long Twilight Long ", movieTimeslot: "00:00pm - 11:59pm", movieChannel: Channel(withRawValue: "SBS One"), movieRating: Rating(withRawValue: "PG"))
    }
    
}
