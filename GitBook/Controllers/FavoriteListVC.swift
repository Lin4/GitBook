//
//  FavoriteListVC.swift
//  GitBook
//
//  Created by Lingeswaran Kandasamy on 10/14/21.
//

import UIKit

class FavoriteListVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray
        
        PresistanceManager.retrieveFavorites {[weak self] result in
            guard let self = self else {return}
            
            switch result{
            case .success(let favorites):
                print(favorites)
            case .failure(let error):
                break
            }
            
        }
    
    }
}
