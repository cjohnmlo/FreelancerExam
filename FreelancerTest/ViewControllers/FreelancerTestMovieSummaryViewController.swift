//
//  FreelancerTestMovieSummaryViewController.swift
//  FreelancerTest
//
//  Created by Christian John Lo on 02/08/2018.
//  Copyright © 2018 Christian John Lo. All rights reserved.
//

import UIKit
import Bond
import Kingfisher

class FreelancerTestMovieSummaryViewController: UIViewController {

    var viewModel : DisplayableMovieSummary?
    
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieTimeslotLabel: UILabel!
    @IBOutlet weak var movieRatingImageView: UIImageView!
    @IBOutlet weak var movieSummaryLabel: UILabel!
    @IBOutlet weak var summaryLoadingIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = viewModel?.displayableMovie.movieTitle
        self.movieTitleLabel.text = viewModel?.displayableMovie.movieTitle
        self.movieTimeslotLabel.text = viewModel?.displayableMovie.movieTimeslot
        self.movieRatingImageView.image = viewModel?.displayableMovie.ratingImage
        
        _ = viewModel?.movieSummary.observeNext(with: { (movieSummary) in
            if let summary = movieSummary {
                self.movieSummaryLabel.text = summary
                self.summaryLoadingIndicator.isHidden = true
            }
        })
        
        _ = viewModel?.moviePosterURL.observeNext(with: { (posterURL) in
            self.moviePosterImageView.kf.setImage(with: posterURL)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
