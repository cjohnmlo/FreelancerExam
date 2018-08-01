//
//  MovieListProvider.swift
//  FreelancerTest
//
//  Created by Christian John Lo on 31/07/2018.
//  Copyright © 2018 Christian John Lo. All rights reserved.
//

protocol MovieListProviderDelegate {
    func movieListProvider(_ : MovieListProvider, addedMoviesWithRange range: Range<Int>)
}

protocol MovieListProvider {
    var delegate : MovieListProviderDelegate? {set get}
    func getMovieCount() -> Int
    func getMovie(atIndex: Int) -> DisplayableMovie?
    mutating func loadMoreMovies()
}
