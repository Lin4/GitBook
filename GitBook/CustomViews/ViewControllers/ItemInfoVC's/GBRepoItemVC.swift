//
//  GBRepoItemVC.swift
//  GitBook
//
//  Created by Lingeswaran Kandasamy on 10/22/21.
//

import UIKit

protocol GBRepoItemVCDeligate: AnyObject {
    func didTapGitHubProfile(for user: User)
}

class GBRepoItemVC: GBItemInfoVC {
    
    weak var delegate: GBRepoItemVCDeligate!
    
    init(user: User, delegate: GBRepoItemVCDeligate) {
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
        itemInfoViewOne.set(itemInfoType: .repos, withCount: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.publicGists)
        actionButton.set(backgroundColor: .systemTeal, title: "GitHub Profile")
    }
    
    override func actionButtonTapped() {
        delegate.didTapGitHubProfile(for: user)
    }
}
