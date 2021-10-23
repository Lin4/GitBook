//
//  GBFollowerItemVC.swift
//  GitBook
//
//  Created by Lingeswaran Kandasamy on 10/23/21.
//

import UIKit

class GBFollowerItemVC: GBItemInfoVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .followes, withCount: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "GitHub Followers")
    }
    
}
