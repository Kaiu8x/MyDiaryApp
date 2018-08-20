//
//  Client.swift
//  desk
//
//  Created by Kai K on 6/7/18.
//  Copyright © 2018 Kaiu8x. All rights reserved.
//

import Foundation

class Session {
    var contArray = [contentDict]()
    
    func makeSession(ownerName: String, repositoryName: String, issueNumber: Int ,completion: @escaping (_ sucess:Bool) -> Void) {
       
        let url = URL(string : "https://api.github.com/repos/\(ownerName)/\(repositoryName)/issues/\(issueNumber)/comments")!
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        request.addValue("application/vnd.github.v3.text+json", forHTTPHeaderField: "Accept")
        
        let httpHeaderRequests = ["Authorization" : "token 8cb0f7220dfc3847fa6e048daa4031028339cb14","Accept" : "application/vnd.github.v3.text+json"]
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = httpHeaderRequests
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let e = error {
                print(e)
            } else {
                if let jsonData = data, data != nil {
                   completion(self.decodeJSON(jsonData))
                }
            }
        }
        task.resume()
    }
    
    func decodeJSON(_ data: Data) -> Bool {
        do {
            let decoder = JSONDecoder()
            //let comments = try decoder.decode([String:String].self, from: data)
            let comments = try decoder.decode([IssueComment].self, from: data)
            //print(comments)
            parseContent(comments)
            return true
        } catch (let e){
            print("parse error!\(e)")
        }
        return false
    }
    
    func parseContent(_ text: [IssueComment]) {
        var cell = [contentDict]()
        for i in text {
            let body = i.body_text
            let cellCont = try body.split(separator: "\n", maxSplits: 1).map(String.init)
            //print(cellCont)
            cell.append(contentDict(title: cellCont[0], content: cellCont[1], id: i.id))
        }
        self.contArray = cell
        //print(self.contArray)
    }
    
    func getContArray() -> [contentDict]{
        return self.contArray
    }
    
}

