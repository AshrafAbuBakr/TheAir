//
//  ShowDetailsViewModel.swift
//  TheAir
//
//  Created by Ashraf Abu Bakr on 02/12/2020.
//

import Foundation

protocol ShowDetailsViewPrototocol: class {
    func detailsSuccess()
    func detailsFailed(errorMessage: String)
    func castSuccess()
    func castFailed(errorMessage: String)
}

class ShowDetailsViewModel {
    
    var show: TopRatedResult?
    var showDetails: DetailsResponse? {
        didSet {
            view?.detailsSuccess()
        }
    }
    
    var showCredits: CreditsResponse? {
        didSet {
            view?.castSuccess()
        }
    }
    weak var view: ShowDetailsViewPrototocol?
    
    func getDetails() {
        RequestManager.beginRequest(withTargetType: Services.self, andTarget: Services.getShowDetails(showID: show?.id ?? 0), responseModel: DetailsResponse.self) { [unowned self] (data, error) in
            if let data = data as? DetailsResponse{
                showDetails = data
            } else {
                view?.detailsFailed(errorMessage: Localization.Error.GeneralError)
            }
        }
    }
    
    func getCast() {
        RequestManager.beginRequest(withTargetType: Services.self, andTarget: Services.getCredits(showID: show?.id ?? 0), responseModel: CreditsResponse.self) { [unowned self] (data, error) in
            if let data = data as? CreditsResponse{
                showCredits = data
            } else {
                view?.castFailed(errorMessage: Localization.Error.GeneralError)
            }
        }
    }
    
    func posterURL() -> URL? {
        let path = showDetails?.backdropPath ?? show?.posterPath ?? ""
        let poster = LARGE_IMAGE_BASEURL + path
        return URL(string: poster)
    }
    
    func numberOfNetworks() -> Int {
        return showDetails?.networks?.count ?? 0
    }
    
    func networkName(forIndex index: Int) -> String {
        guard index < showDetails?.networks?.count ?? 0 else {
            return ""
        }
        return showDetails?.networks?[index].name ?? ""
    }
    
    func showGenres() -> String {
        guard  showDetails?.genres != nil, showDetails!.genres!.count > 0  else {
            return ""
        }
        var genres = ""
        for genre in showDetails!.genres! {
            genres += genre.name ?? ""
            if genre != showDetails!.genres!.last {
                genres += ", "
            }
        }
        return genres
    }
    
    func castCount() -> Int {
        showCredits?.cast?.count ?? 0
    }
    
    func castMemberName(ForIndex index: Int) -> String {
        guard index < showCredits?.cast?.count ?? 0 else {
            return ""
        }
        return showCredits?.cast?[index].name ?? ""
    }
    
    func castMemberCharacterName(ForIndex index: Int) -> String {
        guard index < showCredits?.cast?.count ?? 0 else {
            return ""
        }
        return showCredits?.cast?[index].character ?? ""
    }
    
    func castMemberImageURL(ForIndex index: Int) -> URL? {
        guard index < showCredits?.cast?.count ?? 0 else {
            return nil
        }
        let path = showCredits?.cast?[index].profilePath ?? ""
        let poster = IMAGE_BASEURL + path
        return URL(string: poster)
    }
    
}
