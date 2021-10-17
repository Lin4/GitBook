//
//  FollowerListVC.swift
//  GitBook
//
//  Created by Lingeswaran Kandasamy on 10/15/21.
//

import UIKit

class FollowerListVC: UIViewController {

    var userName: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        
        NetworkManager.shared.getFollowers(for: userName, page: 1) { (followers, errorMessage) in
            guard let followers = followers else {
                self.presentGBAlertOnMainThread(title: "Bad Stuff Happend", message: errorMessage!, buttonTitle: "Ok")
                return
            }
            
            
            print("Followers.count = \(followers.count)")
            print(followers)
    }
}
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        
    }

}