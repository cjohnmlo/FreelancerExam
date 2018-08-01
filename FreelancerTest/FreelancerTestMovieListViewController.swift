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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // mock movielistprovider
        self.viewModel = MovieListProviderMock()
        
        self.movieListTableView.delegate = self
        self.movieListTableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FreelancerTestMovieListViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let displayableMovie = self.viewModel?.getMovie(atIndex: indexPath.row) else {
            print("Model error.")
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListCellIdentifier") as! MovieListTableViewCell
        cell.customize(movie: displayableMovie)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let viewModel = self.viewModel {
            return viewModel.getMovieCount()
        }
        else {
            return 0
        }
    }
}

extension FreelancerTestMovieListViewController : UITableViewDelegate {
    
}
