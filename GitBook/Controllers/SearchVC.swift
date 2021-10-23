//
//  SearchVC.swift
//  GitBook
//
//  Created by Lingeswaran Kandasamy on 10/14/21.
//

import UIKit

class SearchVC: UIViewController {
    
    let logoImageView = UIImageView()
    let userNameTF = GBTextField()
    let callToActionButton = GBButton(backgroundColor: .systemGreen, title: "Get Followers")
    
    var isUserNameEntered: Bool{
        return !userNameTF.text!.isEmpty
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureLogoImageView()
        configureTextField()
        configureCallToActionButton()
        createDismissKeyboardTabGesture()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    func createDismissKeyboardTabGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }

   @objc func pushFollowerListVC() {
    guard isUserNameEntered else {
        presentGBAlertOnMainThread(title: "Empty UserName", message: "Please enter a username, we need to know who you are 😎" , buttonTitle: "Ok")
        return
    }
    let followerListVC      = FollowerListVC()
    followerListVC.userName = userNameTF.text
    followerListVC.title    = userNameTF.text
    navigationController?.pushViewController(followerListVC, animated: true)
    
   }
    
    
    
    
    func configureLogoImageView() {
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "gb-logo")!
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    
    func configureTextField() {
        view.addSubview(userNameTF)
        userNameTF.delegate = self
        NSLayoutConstraint.activate([
            userNameTF.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant:  48),
            userNameTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            userNameTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            userNameTF.heightAnchor.constraint(equalToConstant: 50)
        
        ])
    }
    
    
    func configureCallToActionButton() {
        view.addSubview(callToActionButton)
        
        callToActionButton.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
}

extension SearchVC: UISearchTextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("hello text")
        return true
    }
}
