//
//  ErrorMessage.swift
//  GitBook
//
//  Created by Lingeswaran Kandasamy on 10/17/21.
//

import Foundation
enum GBError: String, Error {
    case invalidUserName = "this username created an invalid request. Please try again"
    case unableToComplete = "unable to complete your request. Please check your internet connection"
    case invalidResponse = "invalid response from the server. Please try again."
    case invalidData = "The data received from the server is invalid. Please try again."
    
}
