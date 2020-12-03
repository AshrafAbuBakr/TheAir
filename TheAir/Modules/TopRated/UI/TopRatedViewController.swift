//
//  ViewController.swift
//  TheAir
//
//  Created by Ashraf on 30/11/2020.
//

import UIKit
import ObjectMapper

class TopRatedViewController: UIViewController, BaseView {
    
    @IBOutlet weak var topRatedShowsTableView: UITableView!
   
    var viewModel: TopRatedViewModel!
    var selectedShowIndex: Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initViewModel()
        addPullToRefresh()
        viewModel.getTopRatedFirstPage()
    }
    
    private func initViewModel() {
        viewModel = TopRatedViewModel()
        viewModel.view = self
    }
    
    func addPullToRefresh() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        topRatedShowsTableView.refreshControl = refreshControl
    }
    
    @objc func refresh() {
        viewModel.getTopRatedFirstPage()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetailsSegue" {
            if let showDetailsVC = segue.destination as? ShowDetailsViewController {
                let detailsViewModel = ShowDetailsViewModel()
                detailsViewModel.show = viewModel.show(forIndex: selectedShowIndex)
                showDetailsVC.viewModel = detailsViewModel
                detailsViewModel.view = showDetailsVC
            }
        }
    }
}


extension TopRatedViewController: TopRatedViewProtocol {
    func TopRatedSuccess() {
        topRatedShowsTableView.reloadData()
        topRatedShowsTableView.refreshControl?.endRefreshing()
    }
    
    func TopRatedFailed(errorMessage: String)
    {
        showMessageAlert(title: "", message: errorMessage)
    }
}

extension TopRatedViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TopRatedCell", for: indexPath) as? TopRatedTableViewCell {
            let title = viewModel.title(forIndex: indexPath.row)
            let airDate = viewModel.firstAirDate(forIndex: indexPath.row)
            let avgRating = viewModel.avgRate(forIndex: indexPath.row)
            let posterPath = viewModel.posterURL(forIndex: indexPath.row)
            cell.setupCell(title: title, airDate: airDate, avgRate: avgRating, posterURL: posterPath)
            return cell
        } else {
            fatalError("Could not find top rated Cell!")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedShowIndex = indexPath.row
        performSegue(withIdentifier: "ShowDetailsSegue", sender: self)
    }
}
