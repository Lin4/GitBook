//
//  UserInfoVC.swift
//  GitBook
//
//  Created by Lingeswaran Kandasamy on 10/21/21.
//

import UIKit

class UserInfoVC: UIViewController {
    
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    var itemViews: [UIView] = []
    
    var userName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        layoutUI()
        getUserInfo()
        
        }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismssVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    
    func getUserInfo() {
        NetworkManager.shared.getUserInfo(for: userName) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.add(childVC: GBUserInfoHeaderVC(user: user), to: self.headerView)
                }
            case .failure(let error):
                print(error)
                break
                }
            }
    }
    
   func layoutUI() {
       let padding: CGFloat = 20
       let itemHeight: CGFloat = 140
       
       itemViews = [headerView, itemViewOne, itemViewTwo]
       for itemView in itemViews {
           view.addSubview(itemView)
           itemView.translatesAutoresizingMaskIntoConstraints = false
           
           NSLayoutConstraint.activate([
           itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
           itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -padding),
           
           ])
           
       }

       itemViewOne.backgroundColor = .systemPink
       itemViewTwo.backgroundColor = .systemTeal
  
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
            
           itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
           itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight)
     
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
