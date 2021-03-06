//
//  TopRatedViewModel.swift
//  TheAir
//
//  Created by Ashraf Abu Bakr on 01/12/2020.
//

import Foundation

protocol TopRatedViewProtocol: class {
    func TopRatedSuccess()
    func TopRatedFailed(errorMessage: String)
}

class TopRatedViewModel {
    var currentPage: Int = 1
    weak var view: TopRatedViewProtocol?
    var topRated: TopRatedResponse? {
        didSet {
            view?.TopRatedSuccess()
        }
    }
    
    func getTopRatedFirstPage() {
        RequestManager.beginRequest(withTargetType: Services.self, andTarget: Services.getTopRated(pageNumber: currentPage), responseModel: TopRatedResponse.self) { [unowned self] (data, error) in
            if let data = data as? TopRatedResponse, error == nil {
                topRated = data
                topRated!.results?.sort {
                    $0.voteAverage > $1.voteAverage }
            } else {
                view?.TopRatedFailed(errorMessage: ErrorHandler.errorMesage(forErrorCode: .generalError))
            }
        }
    }
    
    func getFavorites() {
        let shows = FavoritesHandler.shared.getAllFavorites()
        let results = TopRatedResponse(results: shows)
        topRated = results
        
    }
    
    func numberOfItems() -> Int {
        return topRated?.results?.count ?? 0
    }
    
    func title(forIndex index: Int) -> String {
        guard index < topRated?.results?.count ?? 0 else {
            return ""
        }
        
        return topRated?.results?[index].name ?? ""
    }
    
    func avgRate(forIndex index: Int) -> Float {
        guard index < topRated?.results?.count ?? 0 else {
            return 0.0
        }
        
        return topRated?.results?[index].voteAverage ?? 0.0
    }
    
    func firstAirDate(forIndex index: Int) -> String {
        guard index < topRated?.results?.count ?? 0 else {
            return ""
        }
        
        return topRated?.results?[index].firstAirDate ?? ""
    }
    
    func posterURL(forIndex index: Int) -> String {
        guard index < topRated?.results?.count ?? 0 else {
            return ""
        }
        if let path = topRated?.results?[index].posterPath {
            return IMAGE_BASEURL + path
        }
        return ""
    }
    
    func show(forIndex index: Int) -> TopRatedResult? {
        guard index < topRated?.results?.count ?? 0 else {
            return nil
        }
        return topRated?.results?[index] ?? nil
    }
}
