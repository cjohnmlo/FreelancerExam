//
//  Movie.swift
//  FreelancerTest
//
//  Created by Christian John Lo on 31/07/2018.
//  Copyright © 2018 Christian John Lo. All rights reserved.
//

import Foundation
import UIKit

struct Movie : DisplayableMovie {
    var movieTitle: String
    var movieTimeslot: String
    var channelImage : UIImage?
    var ratingImage : UIImage?
    
    init(movieTitle: String, movieTimeslot: String, movieChannel: Channel, movieRating: Rating) {
        self.movieTitle = movieTitle
        self.movieTimeslot = movieTimeslot
        self.channelImage = movieChannel.channelImage()
        self.ratingImage = movieRating.ratingImage()
    }
    
}
