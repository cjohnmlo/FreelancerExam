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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // mock movielistprovider
        self.viewModel = MovieListProviderMock()
        self.viewModel?.delegate = self
        
        self.movieListTableView.delegate = self
        self.movieListTableView.dataSource = self
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
        summaryVC.viewModel = MovieSummaryViewModelMock(movieDetails: self.selectedMovie!)
    }


}

extension FreelancerTestMovieListViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let displayableMovie = self.viewModel?.getMovie(atIndex: indexPath.row) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListCellIdentifier") as! MovieListTableViewCell
            cell.customize(movie: displayableMovie)
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListLoadMoreCellIndicator")!
            return cell
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
            self.viewModel?.loadMoreMovies()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedMovie = viewModel?.getMovie(atIndex: indexPath.row)
        self.performSegue(withIdentifier: "movieListToMoviesummarySegue", sender: self)
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if indexPath.row == self.viewModel?.getMovieCount() {
            return nil
        }
        else {
            return indexPath
        }
    }
}

extension FreelancerTestMovieListViewController : MovieListProviderDelegate {
    func movieListProvider(_: MovieListProvider, addedMoviesWithRange range: Range<Int>) {
        
        var indexPaths : [IndexPath] = []
        for row in range.lowerBound...range.upperBound {
            indexPaths.append(IndexPath(row: row, section: 0))
        }
        
        self.movieListTableView.beginUpdates()
        // delete the loading indicator
        self.movieListTableView.deleteRows(at: [indexPaths[0]], with: .automatic)
        self.movieListTableView.insertRows(at: indexPaths, with: .top)
        self.movieListTableView.endUpdates()
    }
}
