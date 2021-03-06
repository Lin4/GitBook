//
//  GBAlertVC.swift
//  GitBook
//
//  Created by Lingeswaran Kandasamy on 10/16/21.
//


import UIKit

class GBAlertVC: UIViewController {
    
    let containerView = GBAllertContainerView()
    let titleLabel      = GBTitleLabel(textAlignment: .center, fontSize: 20)
    let messageLabel    = GBBodyLabel(textAlignment: .center)
    let alertButton     = GBButton(color: .systemPink, title: "Ok", systemImageName: "checkmark.circle")
    
    var alertTitle: String?
    var message: String?
    var buttonTitle: String?
    
    var padding: CGFloat = 20

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        view.addSubviews(containerView, titleLabel, alertButton, messageLabel)
        
        configureContainerView()
        configureTitleLabel()
        configureAlertButton()
        configureMessageLabel()
    }
    
    
    init(title: String, message: String, buttonTitle: String){
        super.init(nibName: nil, bundle: nil)
        self.alertTitle     = title
        self.message        = message
        self.buttonTitle    = buttonTitle
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureContainerView() {
     
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 220)
            
        ])
        
    }
    
    
    func configureTitleLabel() {
     
        titleLabel.text = alertTitle ?? "Error Loding "
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    
    func configureAlertButton() {
        
        alertButton.setTitle(buttonTitle ?? "Ok", for: .normal)
        alertButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            alertButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            alertButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            alertButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            alertButton.heightAnchor.constraint(equalToConstant: 44)
        
        ])
    }
    
    
    func configureMessageLabel() {
      
        messageLabel.text           = message ?? "Unable to load message"
        messageLabel.numberOfLines  = 4
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            messageLabel.bottomAnchor.constraint(equalTo: alertButton.topAnchor, constant: -12)
        ])
    }
    

    @objc func dismissVC() {
        dismiss(animated: true)
    }
}
       
