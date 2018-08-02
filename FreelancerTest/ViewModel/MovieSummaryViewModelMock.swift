//
//  MovieListSummaryMock.swift
//  FreelancerTest
//
//  Created by Christian John Lo on 02/08/2018.
//  Copyright © 2018 Christian John Lo. All rights reserved.
//

import Foundation
import Bond

class MovieSummaryViewModelMock : DisplayableMovieSummary {
    var displayableMovie: DisplayableMovie
    var movieSummary: Observable<String?>
    var moviePosterURL: Observable<URL?>
    
    init(movieDetails: DisplayableMovie) {
        self.displayableMovie = movieDetails
        
        self.movieSummary = Observable<String?>("")
        self.moviePosterURL = Observable<URL?>(URL(string: ""))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.movieSummary.next("Movie summary mock Movie summary mock Movie summary mock Movie summary mock Movie summary mock Movie summary mock Movie summary mock Movie summary mock")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.moviePosterURL.next(URL(string: "https://ae01.alicdn.com/kf/HTB1YQRYKFXXXXa5XFXXq6xXFXXXT/BreakingBad-Breaking-Bad-Silk-Canvas-Wall-Posters-HD-Modern-Home-Decor-Movie-Comic-Music-Landscape-Poster.jpg_640x640.jpg"))
        }
    }
    
}
