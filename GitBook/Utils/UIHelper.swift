//
//  UIHelper.swift
//  GitBook
//
//  Created by Lingeswaran Kandasamy on 10/19/21.
//

import UIKit

struct UIHelper {
    static func threeColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        
        let width                           = view.bounds.width
        let padding: CGFloat                = 12
        let minimumItemSpacing: CGFloat     = 10
        let availableWidth                  = width - (padding * 2) - (minimumItemSpacing * 2)
        let cellWidth                       = availableWidth / 3
        
        let flowLayout                      = UICollectionViewFlowLayout()
        flowLayout.sectionInset             = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize                 = CGSize(width: cellWidth, height: cellWidth + 40)
        
        
        return flowLayout
    }
    
}