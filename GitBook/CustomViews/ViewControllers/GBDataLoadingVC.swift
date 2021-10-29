//
//  GBDataLoadingVC.swift
//  GitBook
//
//  Created by Lingeswaran Kandasamy on 10/28/21.
//

import UIKit

class GBDataLoadingVC: UIViewController {
    
    var containerView: UIView!
    
    func showLodingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView?.backgroundColor      = .systemBackground
        containerView.alpha                 = 0
        
        UIView.animate(withDuration: 0.25) {self.containerView.alpha = 0.8}
        
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
            self.containerView?.removeFromSuperview()
            self.containerView = nil
        }
    }
    

    func showEmptyStateView(with message: String, in view: UIView) {
        let emptyStateView = GFEmptyFolowerList(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
}

