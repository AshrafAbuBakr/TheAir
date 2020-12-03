//
//  ViewController.swift
//  TheAir
//
//  Created by Ashraf on 30/11/2020.
//

import UIKit
import ObjectMapper

enum ShowsListMode {
    case popular
    case favorites
}

class TopRatedViewController: UIViewController, BaseView {
    
    @IBOutlet weak var topRatedShowsTableView: UITableView!
   
    var viewModel: TopRatedViewModel!
    var selectedShowIndex: Int = -1
    var mode: ShowsListMode = .popular
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initViewModel()
        loadData()
    }
    
    func loadData() {
        switch mode {
        case .popular:
            addPullToRefresh()
            viewModel.getTopRatedFirstPage()
        case .favorites:
//            topRatedShowsTableView.isEditing = true
//            topRatedShowsTableView.allowsSelectionDuringEditing = true
            viewModel.getFavorites()
        }
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
    
    @IBAction func favoritesButtonTapped(_ sender: Any) {
        if let favoritesVC = storyboard?.instantiateViewController(identifier: "ShowsListVC") as? TopRatedViewController {
            favoritesVC.mode = .favorites
            present(favoritesVC, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetailsSegue" {
            if let showDetailsVC = segue.destination as? ShowDetailsViewController {
                let detailsViewModel = ShowDetailsViewModel(show: viewModel.show(forIndex: selectedShowIndex))
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
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        switch mode {
        case .favorites:
            return true
        default:
            return false
        }
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            if let show = viewModel.show(forIndex: indexPath.row) {
                FavoritesHandler.shared.removeFavorite(show: show)
//                tableView.deleteRows(at: [indexPath], with: .fade)
                loadData()
            }
        }
    }
}
