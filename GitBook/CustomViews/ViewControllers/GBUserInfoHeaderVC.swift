//
//  GBUserInfoHeaderVC.swift
//  GitBook
//
//  Created by Lingeswaran Kandasamy on 10/22/21.
//

import UIKit

class GBUserInfoHeaderVC: UIViewController {
    
    let avatarImageView = GBAvatarImageView(frame: .zero)
    let userNameLbl = GBTitleLabel(textAlignment: .left, fontSize: 34)
    let nameLabel = GBSecondaryTitleLabel(fontSize: 18)
    let locationImage = UIImageView()
    let locationLbl = GBSecondaryTitleLabel(fontSize: 18)
    let bioLbl = GBBodyLabel(textAlignment: .left)
    
    var user: User!
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        layoutUI()
        configureUIElements()
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureUIElements() {
        downloadImage()
        userNameLbl.text        = user.login
        nameLabel.text          = user.name ?? ""
        locationLbl.text        = user.location ?? ""
        bioLbl.text             = user.bio ?? ""
        bioLbl.numberOfLines    = 3
        locationImage.image     = SFSymbols.location
        locationImage.tintColor = .secondaryLabel
        
    }
    
    
    func addSubviews() {
        view.addSubviews(avatarImageView, userNameLbl, nameLabel, locationImage, locationLbl, bioLbl)
        
    }
    
    
    func downloadImage() {
        NetworkManager.shared.downloadImage(from: user.avatarUrl) {[weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async { self.avatarImageView.image = image }
        }
    }
    
    
    func layoutUI() {
        let padding: CGFloat        = 20
        let textAlignment: CGFloat  = 12
        locationImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 90),
            avatarImageView.heightAnchor.constraint(equalToConstant: 90),
            
            
            userNameLbl.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            userNameLbl.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textAlignment),
            userNameLbl.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            userNameLbl.heightAnchor.constraint(equalToConstant: 38),
            
            
            nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textAlignment),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            
            locationImage.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            locationImage.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textAlignment),
            locationImage.widthAnchor.constraint(equalToConstant: 20),
            locationImage.heightAnchor.constraint(equalToConstant: 20),
            
            locationLbl.centerYAnchor.constraint(equalTo: locationImage.centerYAnchor, constant: textAlignment),
            locationLbl.leadingAnchor.constraint(equalTo: locationImage.trailingAnchor, constant: 5),
            locationLbl.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            locationLbl.heightAnchor.constraint(equalToConstant: 20),
            
            bioLbl.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: textAlignment),
            bioLbl.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            bioLbl.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bioLbl.heightAnchor.constraint(equalToConstant: 90),
            
    
        ])
    }
}
