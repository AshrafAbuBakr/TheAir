//
//  Connectivity.swift
//  TheAir
//
//  Created by Ashraf on 30/11/2020.
//

import Foundation
import Alamofire

class Connectivity {
    
    private let manager = NetworkReachabilityManager(host: "www.google.com")
    static let shared: Connectivity = { return Connectivity() }()
    
    
    func isConnectedToInternet() -> Bool {
        return manager?.isReachable ?? false
    }
    
    func startListening() {
        manager?.startListening(onUpdatePerforming: { (status) in
            
        })
    }
}
