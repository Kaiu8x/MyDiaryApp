//
//  Structs.swift
//  desk
//
//  Created by Kai K on 6/12/18.
//  Copyright © 2018 Kaiu8x. All rights reserved.
//

import Foundation

struct contentDict : Codable {
    var title : String
    var content : String
    var id : Int
}

struct IssueComment : Codable {
    var url : String
    var html_url : String
    var issue_url : String
    var id : Int
    var node_id : String
    var created_at : String
    var updated_at : String
    var author_association : String
    var body_text : String
    struct User : Codable {
        var login : String
        var id : Int
        var node_id : String
        var avatar_url : String
        var gravatar_id : String
        var url : String
        var html_url : String
        var followers_url : String
        var following_url : String
        var gists_url : String
        var starred_url : String
        var subscriptions_url : String
        var organizations_url : String
        var repos_url : String
        var events_url : String
        var received_events_url : String
        var type : String
        var site_admin : Bool
    }
    var user : User
}
