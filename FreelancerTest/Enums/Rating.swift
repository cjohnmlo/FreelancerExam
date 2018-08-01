//
//  Rating.swift
//  FreelancerTest
//
//  Created by Christian John Lo on 01/08/2018.
//  Copyright © 2018 Christian John Lo. All rights reserved.
//

import Foundation
import UIKit

enum Rating: String {
    case PG
    case NR
    case MA
    case M
    case G
    case AV
    case Unknown
    
    init(withRawValue: String) {
        if let rating = Rating(rawValue: withRawValue) {
            self = rating
        }
        else {
            self = .Unknown
        }
    }
    
    func ratingImage() -> UIImage? {
        return UIImage(named: self.rawValue)
    }
}
