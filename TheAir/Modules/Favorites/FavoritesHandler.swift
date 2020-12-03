//
//  FavoritesHandler.swift
//  TheAir
//
//  Created by Ashraf Abu Bakr on 03/12/2020.
//

import Foundation
import RealmSwift

class FavoritesHandler {
    static let shared = FavoritesHandler()
    
    var realm: Realm? {
        do {
            let realm = try Realm()
            return realm
        } catch let error as NSError {
            // handle error
            print(error.localizedDescription)
            return nil
        }
    }
    
    func saveFavorite(show: TopRatedResult) {
        guard realm != nil else {
            return
        }
        
        try! realm!.write {
            realm!.add(show)
        }
    }
    
    func removeFavorite(show: TopRatedResult) {
        guard realm != nil else {
            return
        }
        let predicate = NSPredicate(format: "id == %d", show.id)
        if let filterResult = realm!.objects(TopRatedResult.self).filter(predicate).first {
            try! realm!.write {
                realm!.delete(filterResult)
            }
        }
    }
    
    func getAllFavorites() -> [TopRatedResult] {
        guard realm != nil else {
            return []
        }
        let favorites = realm!.objects(TopRatedResult.self)
        return Array(favorites)
    }
    
    func isFavorie(show: TopRatedResult) -> Bool {
        guard realm != nil else {
            return false
        }
        let predicate = NSPredicate(format: "id == %d", show.id)
        let filterResult = realm!.objects(TopRatedResult.self).filter(predicate)
        if filterResult.count > 0 {
            return true
        }
        return false
    }
    
}
