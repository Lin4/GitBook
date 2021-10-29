//
//  GBItemInfoVC.swift
//  GitBook
//
//  Created by Lingeswaran Kandasamy on 10/22/21.
//

import UIKit

class GBItemInfoVC: UIViewController {
    
    let stakeView           = UIStackView()
    let itemInfoViewOne     = GBItemInfoView()
    let itemInfoViewTwo     = GBItemInfoView()
    let actionButton        = GBButton()
    
    var user: User!
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackGroundView()
        configureActionButton()
        layoutUI()
        configureStakeView()
        
    }
    
    
    private func configureBackGroundView() {
        view.layer.cornerRadius     = 18
        view.backgroundColor        = .secondarySystemBackground
    }
    
    
    private func configureStakeView() {
        stakeView.axis          = .horizontal
        stakeView.distribution  = .equalSpacing
        
        stakeView.addArrangedSubview(itemInfoViewOne)
        stakeView.addArrangedSubview(itemInfoViewTwo)
    }
    
    
    private func configureActionButton() {
        
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
    }
    
    
    @objc func actionButtonTapped() {}
    
    
    private func layoutUI() {
        self.view.addSubviews(stakeView, actionButton)
       
        stakeView.translatesAutoresizingMaskIntoConstraints = false
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            stakeView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stakeView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: padding),
            stakeView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stakeView.heightAnchor.constraint(equalToConstant: 50),
            
            actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        
        ])
    }
}
