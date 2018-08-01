//
//  DisplayableMovie.swift
//  FreelancerTest
//
//  Created by Christian John Lo on 31/07/2018.
//  Copyright © 2018 Christian John Lo. All rights reserved.
//

import Foundation
import UIKit

protocol DisplayableMovie {
    var movieTitle : String {get}
    var movieTimeslot : String {get}
    var channelImage : UIImage? {get}
    var ratingImage : UIImage? {get}
}
