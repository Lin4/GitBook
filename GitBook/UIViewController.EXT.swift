//
//  UIViewController.EXT.swift
//  GitBook
//
//  Created by Lingeswaran Kandasamy on 10/16/21.
//

import UIKit

extension UIViewController {
    func presentGBAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = GBAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
}

