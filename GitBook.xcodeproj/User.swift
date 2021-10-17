//
//  User.swift
//  GitBook
//
//  Created by Lingeswaran Kandasamy on 10/17/21.
//

import Foundation
struct User: Codable{
    var login: String
    var avatarUrl: String
    var name: String?
    var location: String?
    var bio: String?
    var publicRepos: Int
    var publicGists: Int
    var htmlUrl: String
    var following: Int
    var followers: Int
    var createdAt: String
}
