//
//  DisplayableMovieSummary.swift
//  FreelancerTest
//
//  Created by Christian John Lo on 02/08/2018.
//  Copyright © 2018 Christian John Lo. All rights reserved.
//

import Foundation
import Bond

protocol DisplayableMovieSummary {
    var displayableMovie : DisplayableMovie {get}
    var movieSummary : Observable<String?> {get}
    var moviePosterURL : Observable<URL?> {get}
}
