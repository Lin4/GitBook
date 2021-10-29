//
//  FavoritesCell.swift
//  GitBook
//
//  Created by Lingeswaran Kandasamy on 10/25/21.
//

import UIKit

class FavoritesCell: UITableViewCell {
    
    static let reuseID  = "FavoritesCell"
    let avatarImageView = GBAvatarImageView(frame: .zero)
    let userNameLbl     = GBTitleLabel(textAlignment: .left, fontSize: 26)
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(favorites: Follower) {
        userNameLbl.text = favorites.login
        NetworkManager.shared.downloadImage(from: favorites.avatarUrl) {[weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async { self.avatarImageView.image = image }
        }
    }
    
    
    private func configure() {
        self.addSubviews(avatarImageView, userNameLbl)
        
        
        accessoryType           = .disclosureIndicator
        let padding: CGFloat    = 12
        
        NSLayoutConstraint.activate([
        
            avatarImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            avatarImageView.heightAnchor.constraint(equalToConstant: 60),
            avatarImageView.widthAnchor.constraint(equalToConstant: 60),
            
            
            userNameLbl.centerYAnchor.constraint(equalTo: centerYAnchor),
            userNameLbl.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 24),
            userNameLbl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            userNameLbl.heightAnchor.constraint(equalToConstant: 40)
        
        
        
        ])
    }
}
