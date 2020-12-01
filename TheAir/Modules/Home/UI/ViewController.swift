//
//  ViewController.swift
//  TheAir
//
//  Created by Ashraf on 30/11/2020.
//

import UIKit
import ObjectMapper

class ViewController: UIViewController, BaseView {
    
    @IBOutlet weak var topRatedShowsTableView: UITableView!
    var viewModel: TopRatedViewModel!
    
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
//        topRatedShowsTableView.addSubview(refreshControl)
    }
    
    @objc func refresh() {
        viewModel.getTopRatedFirstPage()
    }
}


extension ViewController: TopRatedViewProtocol {
    func TopRatedSuccess() {
        topRatedShowsTableView.reloadData()
        topRatedShowsTableView.refreshControl?.endRefreshing()
    }
    
    func TopRatedFailed(errorMessage: String)
    {
        showMessageAlert(title: "", message: errorMessage)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
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
}
