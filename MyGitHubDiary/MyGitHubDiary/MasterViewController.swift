//
//  MasterViewController.swift
//  desk
//
//  Created by Kai K on 6/7/18.
//  Copyright © 2018 Kaiu8x. All rights reserved.
//

import UIKit
import Foundation

class MasterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var addCommentButton: UIBarButtonItem!
    @IBOutlet weak var tableViewMain: UITableView!
    var table1Cont : [contentDict] = []
    let c = Session()
    
    var ownerName : String?
    var repositoryName : String?
    var issueNumber : Int?
    var refreshControl = UIRefreshControl()
    
    
    //typealias CompletionHandler = (_ sucess:Bool) -> Void
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadContent()
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControlEvents.valueChanged)
        tableViewMain.addSubview(refreshControl)
        
        //tableViewMain.reloadData()
        tableViewMain.delegate = self
        tableViewMain.dataSource = self
        tableViewMain.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    func loadContent() {
        c.makeSession(ownerName: ownerName!, repositoryName: repositoryName!, issueNumber: issueNumber!, completion: { (sucess) -> Void in
            if sucess {
                self.table1Cont = self.c.getContArray()
                //print(self.table1Cont)
                DispatchQueue.main.async() {
                    self.tableViewMain.reloadData()
                    self.refreshControl.endRefreshing()
                }
            } else {
                print("WTH")
            }
        })
    }
    
    @objc func refresh(sender:AnyObject) {
        loadContent()
        DispatchQueue.main.async() {
            self.tableViewMain.reloadData()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return table1Cont.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewMain.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = table1Cont[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteComment(id: table1Cont[indexPath.row].id)
            table1Cont.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func deleteComment(id: Int) {
        //let url = URL(string: "https://api.github.com/repos/\(ownerName)/\(repositoryName)/issues/\(issueNumber)/comments")!
        let url = URL(string: "https://api.github.com/repos/ookamiinc/general/issues/comments/\(id)")!
        let httpHeaderRequests = ["Authorization" : "token 8cb0f7220dfc3847fa6e048daa4031028339cb14","Accept" : "application/vnd.github.v3.text+json"]
        
        var request = URLRequest (url: url)
        request.httpMethod = "DELETE"
        request.allHTTPHeaderFields = httpHeaderRequests
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let e = error {
                print(e)
                return
            }
        }
        task.resume()
    }
    
    @IBAction func addCommentButtonPressed(_ sender: Any) {
        print("addCommentButton pressed")
        performSegue(withIdentifier: "addCommentSegue", sender: self)
    }
    
//    @IBAction func addCommentButtonPressed(_ sender: UIBarButtonItem) {
//        print("Add comment pressed")
//        performSegue(withIdentifier: "addCommentSegue", sender: self)
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? CommentViewController {
            print("should go to coment view controller")
            destination.comment = table1Cont[(tableViewMain.indexPathForSelectedRow?.row)!]
        }
        if let destination = segue.destination as? AddCommentViewController {
            print("should go to add view controller")
        }
    }
    
}


