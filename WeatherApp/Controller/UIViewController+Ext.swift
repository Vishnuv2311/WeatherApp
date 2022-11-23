//
//  UIViewController+Ext.swift
//  WeatherApp
//
//  Created by Vishnu V on 23/11/22.
//

import UIKit

extension UIViewController {

    // show alert with "OK" dismiss and title as error description
    func showOKAlert(error:LocalizedError? = nil) {
        let title = error?.localizedDescription ?? "Unknown Error"
        showOKAlert(title: title)
    }
    
    // show alert with "OK" dismiss with title and optional message
    func showOKAlert(title: String, message: String? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

