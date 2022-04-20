//
//  UIViewController+showTost.swift
//  WS_Qualifying
//
//  Created by Илья Абросимов on 20.04.2022.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(text: String?) {
        let alert = UIAlertController(title: text, message: nil, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    func showError(_ error: Error) {
        showAlert(text: error.localizedDescription)
    }
}
