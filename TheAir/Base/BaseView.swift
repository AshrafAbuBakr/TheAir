//
//  BaseView.swift
//  TheAir
//
//  Created by Ashraf Abu Bakr on 02/12/2020.
//

import UIKit

protocol BaseView {
    func showMessageAlert(title: String?, message: String)
}

extension BaseView where Self: UIViewController {
    func showMessageAlert(title: String?, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
