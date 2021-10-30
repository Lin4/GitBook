//
//  GBAvatarImageView.swift
//  GitBook
//
//  Created by Lingeswaran Kandasamy on 10/18/21.
//

import UIKit

class GBAvatarImageView: UIImageView {
    
    let cache               = NetworkManager.shared.cache
    let placeHolderImage    = Images.placeHolder
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func downloadImage(fromURL url: String) {
        Task { image = await  NetworkManager.shared.downloadImage(from: url) ?? placeHolderImage}
    }
    
     
    private func configure() {
        layer.cornerRadius  = 10
        clipsToBounds       = true
        image               = placeHolderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
}
