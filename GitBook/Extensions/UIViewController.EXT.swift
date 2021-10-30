//
//  UIViewController.EXT.swift
//  GitBook
//
//  Created by Lingeswaran Kandasamy on 10/16/21.
//

import UIKit
import SafariServices


extension UIViewController {
    
    func presentGBAlert(title: String, message: String, buttonTitle: String) {
            let alertVC = GBAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            present(alertVC, animated: true)
    }
    
    func presentDefaultError() {
        let alertVC = GBAlertVC(title: "Something Went Wrong",
                                message: "We were unable to complete your task at this time. Please try again.",
                                buttonTitle: "Ok")
        alertVC.modalPresentationStyle  = .overFullScreen
        alertVC.modalTransitionStyle    = .crossDissolve
        present(alertVC, animated: true)
    }
    
    func presentSafariVC(with url: URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true)
    }
}
    
    
   
