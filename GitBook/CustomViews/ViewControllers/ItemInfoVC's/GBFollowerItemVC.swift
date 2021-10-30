//
//  GBFollowerItemVC.swift
//  GitBook
//
//  Created by Lingeswaran Kandasamy on 10/23/21.
//

import UIKit

protocol GBFollowerItemVCDeligate: AnyObject {
    func didTapGetFollowers(for user: User)    
}

class GBFollowerItemVC: GBItemInfoVC {
    
    weak var delegate: GBFollowerItemVCDeligate!
    
    init(user: User, delegate: GBFollowerItemVCDeligate) {
        super.init(user: user)
        self.delegate = delegate
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .followes, withCount: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)
        actionButton.set(color: .systemGreen, title: "GitHub Followers", systemImageName: "cursorarrow.click")
    }
    
    
    override func actionButtonTapped() {
        delegate.didTapGetFollowers(for: user)
    }
}


