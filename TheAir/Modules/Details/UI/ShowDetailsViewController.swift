//
//  ShowDetailsViewController.swift
//  TheAir
//
//  Created by Ashraf Abu Bakr on 02/12/2020.
//

import UIKit
import Kingfisher

class ShowDetailsViewController: UIViewController, BaseView {

    @IBOutlet weak var contentScrollView: UIScrollView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var showTitleLabel: UILabel!
    @IBOutlet weak var episodesLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var networkTableView: UITableView!
    @IBOutlet weak var networksTableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var castLabel: UILabel!
    @IBOutlet weak var castCollectionView: UICollectionView!
    @IBOutlet weak var castCollectionViewHeightConstraint: NSLayoutConstraint!
    
    var viewModel: ShowDetailsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewModel?.getDetails()
        viewModel?.getCast()
        title = viewModel?.show?.name
    }
    
    private func populateUi()  {
        showTitleLabel.text = viewModel?.show?.name ?? ""
        ratingLabel.text = "Rating: \(viewModel?.show?.voteAverage ?? 0.0)"
        episodesLabel.text = "\(viewModel?.showDetails?.numberOfEpisodes ?? 0) Episodes"
        genreLabel.text = (viewModel?.showGenres() ?? "")
        posterImageView.kf.setImage(with: viewModel?.posterURL())
        descriptionLabel.text = viewModel?.show?.overview ?? ""
        networkTableView.reloadData()
        networksTableViewHeightConstraint.constant = networkTableView.contentSize.height
    }

}

extension ShowDetailsViewController: ShowDetailsViewPrototocol {
    func detailsSuccess() {
        populateUi()
        UIView.animate(withDuration: 0.3) { [unowned self] in
            contentScrollView.alpha = 1.0
        }
    }
    
    func detailsFailed(errorMessage: String) {
        showMessageAlert(title: "", message: errorMessage)
    }
    
    func castSuccess() {
        guard viewModel?.castCount() ?? 0 > 0 else {
            castLabel.isHidden = true
            castCollectionView.isHidden = true
            castCollectionViewHeightConstraint.constant = 0.0
            return
        }
        castCollectionView.reloadData()
    }
    
    func castFailed(errorMessage: String) {
        castLabel.isHidden = true
        castCollectionView.isHidden = true
        castCollectionViewHeightConstraint.constant = 0.0
    }
}

extension ShowDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfNetworks() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") {
            cell.textLabel?.text = viewModel?.networkName(forIndex: indexPath.row) ?? ""
            return cell
        } else {
            fatalError("Can't find network cell!")
        }
    }
}

extension ShowDetailsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.castCount() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CastMemberCell", for: indexPath) as? CastMemberCollectionViewCell {
            
            let name = viewModel?.castMemberName(ForIndex: indexPath.item) ?? ""
            let character = viewModel?.castMemberCharacterName(ForIndex: indexPath.item) ?? ""
            let profileURL = viewModel?.castMemberImageURL(ForIndex: indexPath.item) ?? nil
            cell.setupCell(withName: name, character: character, profileURL: profileURL)
            return cell
        } else {
            fatalError("Can't find cast member cell!")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 170.0, height: 250.0)
    }
}
