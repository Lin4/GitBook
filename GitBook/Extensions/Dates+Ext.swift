//
//  Dates+Ext.swift
//  GitBook
//
//  Created by Lingeswaran Kandasamy on 10/23/21.
//

import Foundation

extension Date {
    
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: self)
        
    }
}
