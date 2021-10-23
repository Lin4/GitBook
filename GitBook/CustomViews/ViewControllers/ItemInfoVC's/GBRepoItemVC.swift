//
//  GBRepoItemVC.swift
//  GitBook
//
//  Created by Lingeswaran Kandasamy on 10/22/21.
//

import UIKit

class GBRepoItemVC: GBItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .repos, withCount: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.publicGists)
        actionButton.set(backgroundColor: .systemTeal, title: "GitHub Profile")
    }
    
}
