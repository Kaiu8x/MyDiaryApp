//
//  EditCommentViewController.swift
//  desk
//
//  Created by Kai K on 6/17/18.
//  Copyright © 2018 Kaiu8x. All rights reserved.
//

import UIKit

class EditCommentViewController: UIViewController {

    @IBOutlet weak var editCommentTextView: UITextView!
    @IBOutlet weak var editCommentButton: UIButton!
    
    var ownerName : String = "ookamiinc"
    var repositoryName : String = "general"
    var issueNumber : Int = 3875
    
    var id : Int = 0
    var changeText : String = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        editCommentTextView.text = changeText
        editCommentTextView.isScrollEnabled = true
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func editCommentButtonPressed(_ sender: Any) {
        print("Pressed")
        if (editCommentTextView.text == ""){
            return
        }
        let comment = editCommentTextView.text
        editComment(commentString: comment!)
    }
    
    func editComment(commentString : String) {
        let jsonComment : [String: String] = [
            "body": commentString
        ]
        
        let jsonCommentData = try? JSONSerialization.data(withJSONObject: jsonComment)
        
        let url = URL(string: "https://api.github.com/repos/\(ownerName)/\(repositoryName)/issues/comments/\(id)")!
        let httpHeaderRequests = ["Authorization" : "token 8cb0f7220dfc3847fa6e048daa4031028339cb14","Accept" : "application/vnd.github.v3.text+json"]
        
        var request = URLRequest (url: url)
        request.httpMethod = "PATCH"
        request.allHTTPHeaderFields = httpHeaderRequests
        request.httpBody = jsonCommentData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                //print(responseJSON)
                DispatchQueue.main.async() {
                    //self.addCommentTextView.text = "## \(self.date) ()\n\n## やったこと \n+ \n+ \n+ \n\n## やること \n+ \n+ \n+ \n\n## 一言 \n+ \n+ \n+ "
                    let alertController = UIAlertController(title: "Edit Sucessfull", message:
                        "Your comment was changed", preferredStyle: UIAlertControllerStyle.alert)
                    alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,handler: nil))
                    
                    self.present(alertController, animated: true, completion: nil)
                }
                
            }
        }
        task.resume()
    }
}
