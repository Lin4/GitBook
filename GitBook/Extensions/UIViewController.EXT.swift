//
//  UIViewController.EXT.swift
//  GitBook
//
//  Created by Lingeswaran Kandasamy on 10/16/21.
//

import UIKit
import SafariServices

fileprivate var containerView: UIView!

extension UIViewController {
    func presentGBAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = GBAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    
    func showLodingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView?.backgroundColor      = .systemBackground
        containerView.alpha                 = 0
        
        UIView.animate(withDuration: 0.25) {containerView.alpha = 0.8}
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        
        ])
        
        activityIndicator.startAnimating()
        
    }
    
    func dismissLodingView() {
        DispatchQueue.main.async {
            containerView?.removeFromSuperview()
            containerView = nil
        }

    }
    
    func presentSafariVC(with url: URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true)
    }
    
    func showEmptyStateView(with message: String, in view: UIView) {
        let emptyStateView = GFEmptyFolowerList(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
}

