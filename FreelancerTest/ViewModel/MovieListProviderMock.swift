//
//  MovieListProviderMock.swift
//  FreelancerTest
//
//  Created by Christian John Lo on 01/08/2018.
//  Copyright © 2018 Christian John Lo. All rights reserved.
//

import Foundation

class MovieListProviderMock: MovieListProvider {
    
    // implementations for mock up
    
    var delegate: MovieListProviderDelegate?
    var movies : [DisplayableMovie]
    
    init() {
        self.movies = Array()
        self.movies.append(Movie(movieTitle: "Twilight", movieTimeslot: "00:00pm - 11:59pm", movieChannel: Channel(withRawValue: "SBS One"), movieRating: Rating(withRawValue: "PG")))
        self.movies.append(Movie(movieTitle: "Mulan", movieTimeslot: "1:00pm - 4:00pm", movieChannel: .ELEVEN, movieRating: .AV))
        self.movies.append(Movie(movieTitle: "Men in Black", movieTimeslot: "1:00pm - 4:00pm", movieChannel: .Nine, movieRating: .G))
        self.movies.append(Movie(movieTitle: "Apocalypto", movieTimeslot: "1:00pm - 4:00pm", movieChannel: .SBSTwo, movieRating: .MA))
        self.movies.append(Movie(movieTitle: "Conan", movieTimeslot: "1:00pm - 4:00pm", movieChannel: .SevenMate, movieRating: .PG))
        self.movies.append(Movie(movieTitle: "GATTACA", movieTimeslot: "1:00pm - 4:00pm", movieChannel: .TEN, movieRating: .NR))
        self.movies.append(Movie(movieTitle: "Twilight", movieTimeslot: "00:00pm - 11:59pm", movieChannel: Channel(withRawValue: "SBS One"), movieRating: Rating(withRawValue: "PG")))
        self.movies.append(Movie(movieTitle: "Mulan", movieTimeslot: "1:00pm - 4:00pm", movieChannel: .ELEVEN, movieRating: .AV))
        self.movies.append(Movie(movieTitle: "Men in Black", movieTimeslot: "1:00pm - 4:00pm", movieChannel: .Nine, movieRating: .G))
        self.movies.append(Movie(movieTitle: "Apocalypto", movieTimeslot: "1:00pm - 4:00pm", movieChannel: .SBSTwo, movieRating: .MA))
        self.movies.append(Movie(movieTitle: "Conan", movieTimeslot: "1:00pm - 4:00pm", movieChannel: .SevenMate, movieRating: .PG))
        self.movies.append(Movie(movieTitle: "GATTACA", movieTimeslot: "1:00pm - 4:00pm", movieChannel: .TEN, movieRating: .NR))
        self.movies.append(Movie(movieTitle: "Twilight", movieTimeslot: "00:00pm - 11:59pm", movieChannel: Channel(withRawValue: "SBS One"), movieRating: Rating(withRawValue: "PG")))
        self.movies.append(Movie(movieTitle: "Mulan", movieTimeslot: "1:00pm - 4:00pm", movieChannel: .ELEVEN, movieRating: .AV))
        self.movies.append(Movie(movieTitle: "Men in Black", movieTimeslot: "1:00pm - 4:00pm", movieChannel: .Nine, movieRating: .G))
        self.movies.append(Movie(movieTitle: "Apocalypto", movieTimeslot: "1:00pm - 4:00pm", movieChannel: .SBSTwo, movieRating: .MA))
        self.movies.append(Movie(movieTitle: "Conan", movieTimeslot: "1:00pm - 4:00pm", movieChannel: .SevenMate, movieRating: .PG))
        self.movies.append(Movie(movieTitle: "GATTACA", movieTimeslot: "1:00pm - 4:00pm", movieChannel: .TEN, movieRating: .NR))
        self.movies.append(Movie(movieTitle: "Twilight", movieTimeslot: "00:00pm - 11:59pm", movieChannel: Channel(withRawValue: "SBS One"), movieRating: Rating(withRawValue: "PG")))
        self.movies.append(Movie(movieTitle: "Mulan", movieTimeslot: "1:00pm - 4:00pm", movieChannel: .ELEVEN, movieRating: .AV))
        self.movies.append(Movie(movieTitle: "Men in Black", movieTimeslot: "1:00pm - 4:00pm", movieChannel: .Nine, movieRating: .G))
        self.movies.append(Movie(movieTitle: "Apocalypto", movieTimeslot: "1:00pm - 4:00pm", movieChannel: .SBSTwo, movieRating: .MA))
        self.movies.append(Movie(movieTitle: "Conan", movieTimeslot: "1:00pm - 4:00pm", movieChannel: .SevenMate, movieRating: .PG))
        self.movies.append(Movie(movieTitle: "GATTACA", movieTimeslot: "1:00pm - 4:00pm", movieChannel: .TEN, movieRating: .NR))
        
    }
    
    func getMovieCount() -> Int {
        return self.movies.count
    }
    
    func getMovie(atIndex: Int) -> DisplayableMovie? {
        if (self.movies.count <= atIndex) {
            return nil
        }
        else {
            return self.movies[atIndex]
        }
    }
    
    func loadMoreMovies() {
        let currentCount = self.movies.count
        
        self.movies.append(Movie(movieTitle: "Westworld", movieTimeslot: "2:00pm - 3:00pm", movieChannel: .TEN, movieRating: .PG))
        self.movies.append(Movie(movieTitle: "Northworld", movieTimeslot: "2:00pm - 3:00pm", movieChannel: .SevenMate, movieRating: .PG))
        self.movies.append(Movie(movieTitle: "Eastworld", movieTimeslot: "2:00pm - 3:00pm", movieChannel: .SevenTwo, movieRating: .AV))
        self.movies.append(Movie(movieTitle: "Southworld", movieTimeslot: "2:00pm - 3:00pm", movieChannel: .ABC1, movieRating: .G))
        self.movies.append(Movie(movieTitle: "Southpark", movieTimeslot: "2:00pm - 3:00pm", movieChannel: .ELEVEN, movieRating: .MA))
        self.movies.append(Movie(movieTitle: "Northpark", movieTimeslot: "2:00pm - 3:00pm", movieChannel: .SBSOne, movieRating: .NR))
        self.movies.append(Movie(movieTitle: "Eastpark", movieTimeslot: "2:00pm - 3:00pm", movieChannel: .ABC1, movieRating: .AV))
        self.movies.append(Movie(movieTitle: "Westpark", movieTimeslot: "2:00pm - 3:00pm", movieChannel: .TEN, movieRating: .G))
        self.movies.append(Movie(movieTitle: "Kingdom Hearts", movieTimeslot: "2:00pm - 3:00pm", movieChannel: .TEN, movieRating: .NR))
    
        let lastCount = self.movies.count
        // naive delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.delegate?.movieListProvider(self, addedMoviesWithRange: currentCount..<lastCount)
        }
    }
}
