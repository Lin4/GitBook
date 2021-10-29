//
//  UIView+Ext.swift
//  GitBook
//
//  Created by Lingeswaran Kandasamy on 10/28/21.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        for view in views { addSubview(view) }
    }
}
