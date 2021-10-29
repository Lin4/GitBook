//
//  UITableView+Ext.swift
//  GitBook
//
//  Created by Lingeswaran Kandasamy on 10/29/21.
//

import UIKit

extension UITableView {
    
    func reloadDataOnMainThread() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    
    func removeExessCell() {
        tableFooterView = UIView(frame: .zero)
    }
    
}
