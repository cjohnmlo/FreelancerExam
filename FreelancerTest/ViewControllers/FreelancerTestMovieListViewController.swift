//
//  FreelancerTestMovieListViewController.swift
//  FreelancerTest
//
//  Created by Christian John Lo on 31/07/2018.
//  Copyright © 2018 Christian John Lo. All rights reserved.
//

import UIKit

class FreelancerTestMovieListViewController: UIViewController {

    var viewModel : MovieListProvider?
    @IBOutlet weak var movieListTableView: UITableView!
    
    private var selectedMovie : DisplayableMovie?
    fileprivate var shouldAnimate : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // mock movielistprovider
        //self.viewModel = MovieListProviderMock()
        //self.viewModel?.delegate = self
        
        self.viewModel = BeefMovieListProvider()
        self.viewModel?.delegate = self
        
        self.movieListTableView.delegate = self
        self.movieListTableView.dataSource = self
        self.movieListTableView.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let summaryVC = segue.destination as! FreelancerTestMovieSummaryViewController
        summaryVC.viewModel = MovieDBMovieSummaryViewModel(movieDetails: self.selectedMovie!)
    }


}

extension FreelancerTestMovieListViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let displayableMovie = self.viewModel?.getMovie(atIndex: indexPath.row) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListCellIdentifier") as! MovieListTableViewCell
            cell.customize(movie: displayableMovie)
            return cell
        }
        else if indexPath.row == self.viewModel?.getMovieCount() {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListLoadMoreCellIndicator") as! MovieListLoadingIndicatorTableViewCell
            cell.activityIndicator.startAnimating()
            return cell
        }
        else {
            // return an empty cell. This should not happen. If it does, view model screwed up.
            return UITableViewCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let viewModel = self.viewModel {
            // + 1 for the loading indicator
            return viewModel.getMovieCount() + 1
        }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "TONIGHT"
    }
}

extension FreelancerTestMovieListViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == self.viewModel?.getMovieCount() {
            // We're about to show the loading indicator, time to load more titles
            self.viewModel?.loadMoreMovies()
            shouldAnimate = false
        }
        else if shouldAnimate {
            animateIn(cell: cell, withDelay: 0.6)
        }
    }
    
    // animation from: https://sociumapp.com/2016/11/23/adding-cell-in-uitableview-with-nice-animation.html
    
    fileprivate func animateIn(cell: UITableViewCell, withDelay delay: TimeInterval) {
        let initialScale: CGFloat = 1.2
        let duration: TimeInterval = 0.5
        
        cell.alpha = 0.0
        cell.layer.transform = CATransform3DMakeScale(initialScale, initialScale, 1)
        UIView.animate(withDuration: duration, delay: delay, options: UIViewAnimationOptions.curveEaseOut, animations: {
            cell.alpha = 1.0
            cell.layer.transform = CATransform3DIdentity
        }, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedMovie = viewModel?.getMovie(atIndex: indexPath.row)
        self.performSegue(withIdentifier: "movieListToMoviesummarySegue", sender: self)
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if indexPath.row == self.viewModel?.getMovieCount() {
            // we can't select the loading indicator
            return nil
        }
        else {
            return indexPath
        }
    }
}

extension FreelancerTestMovieListViewController : MovieListProviderDelegate {
    func movieListProvider(_: MovieListProvider, addedMoviesWithRange range: Range<Int>) {
        
        // new movies/titles loaded. Add them to the table
        var indexPaths : [IndexPath] = []
        for row in range.lowerBound...range.upperBound {
            indexPaths.append(IndexPath(row: row, section: 0))
        }
        
        self.movieListTableView.beginUpdates()
        // delete the loading indicator
        self.movieListTableView.deleteRows(at: [indexPaths[0]], with: .none)
        self.movieListTableView.insertRows(at: indexPaths, with: .none)
        self.shouldAnimate = true;
        self.movieListTableView.endUpdates()
    }
}

