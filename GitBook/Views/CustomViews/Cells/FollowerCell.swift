//
//  FollowerCell.swift
//  GitBook
//
//  Created by Lingeswaran Kandasamy on 10/18/21.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    
    static let reuseID = "FollowerCell"
    
    
    let avatarImageView = GBAvatarImageView(frame: .zero)
    let userNameLbl     = GBTitleLabel(textAlignment: .center, fontSize: 16)
    let padding: CGFloat = 8
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
       
    }
    
    func set(follower: Follower){
        userNameLbl.text = follower.login
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        configure()
        
    }
    
    private func configure() {
        addSubview(avatarImageView)
        addSubview(userNameLbl)
        
        NSLayoutConstraint.activate([
        
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            avatarImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            
            userNameLbl.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
            userNameLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            userNameLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            userNameLbl.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
