//
//  UserInfoVC.swift
//  GitBook
//
//  Created by Lingeswaran Kandasamy on 10/21/21.
//

import UIKit

protocol UserInfoVCDelegate: AnyObject {
    func didRequestFollowers(for userName: String)
}

class UserInfoVC: GBDataLoadingVC {
    
    let scrollView  = UIScrollView()
    let contentView = UIView()
    
    let headerView  = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    let dateLabel   = GBBodyLabel(textAlignment: .center)
    var itemViews: [UIView] = []
    

    var userName: String!
    weak var delegate: UserInfoVCDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureScrollView()
        layoutUI()
        getUserInfo()
        
        }

    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismssVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    
    func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.pinToEdges(of: view)
        contentView.pinToEdges(of: scrollView)
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 600)
        ])
    }
    
    
    func getUserInfo() {
        NetworkManager.shared.getUserInfo(for: userName) { [weak self] result in
            guard let self = self else { return }
        
            switch result {
            case .success(let user):
                DispatchQueue.main.async { self.configureUIElements(user: user) }
            case .failure(let error):
                self.presentGBAlertOnMainThread(title: "somthing went wrong", message: error.rawValue, buttonTitle: "Ok")
                }
            }
        }
    
    
    func configureUIElements(user: User) {
        
        self.add(childVC: GBRepoItemVC(user: user, delegate: self), to: self.itemViewOne)
        self.add(childVC: GBFollowerItemVC(user: user, delegate: self), to: self.itemViewTwo)
        self.add(childVC: GBUserInfoHeaderVC(user: user), to: self.headerView)
        self.dateLabel.text = "GitHub since \(user.createdAt.convertToMonthYearFormat())"
    }
    
    
   func layoutUI() {
       let padding: CGFloat = 20
       let itemHeight: CGFloat = 140
       
       itemViews = [headerView, itemViewOne, itemViewTwo, dateLabel]
       for itemView in itemViews {
           contentView.addSubview(itemView)
           itemView.translatesAutoresizingMaskIntoConstraints = false
           
           NSLayoutConstraint.activate([
           itemView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
           itemView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -padding),
           ])
       }

       
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 210),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
            
           itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
           itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }  
    
   
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    
    @objc func dismssVC() {
        dismiss(animated: true)
    }
}


extension UserInfoVC: GBRepoItemVCDeligate, GBFollowerItemVCDeligate {
    func didTapGitHubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentGBAlertOnMainThread(title: "Invalid URL", message: "The URL attached to this user is not valid", buttonTitle: "Ok")

            return
        }
        presentSafariVC(with: url)
   }
   
    
    func didTapGetFollowers(for user: User) {
        guard user.followers != 0 else {
            presentGBAlertOnMainThread(title: "No Followers", message: "This User has no followers, what a shame😂", buttonTitle: "So Sad")
            return
        }

        delegate.didRequestFollowers(for: user.login)
        dismssVC()
    }
}


