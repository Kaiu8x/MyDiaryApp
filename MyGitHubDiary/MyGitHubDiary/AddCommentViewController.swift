//
//  AddCommentViewController.swift
//  desk
//
//  Created by Kai K on 6/14/18.
//  Copyright © 2018 Kaiu8x. All rights reserved.
//

import UIKit
import Foundation

class AddCommentViewController: UIViewController {
    
    @IBOutlet weak var addCommentTextView: UITextView!
    @IBOutlet weak var addCommentButton: UIButton!
    
    var ownerName : String = "ookamiinc"
    var repositoryName : String = "general"
    var issueNumber : Int = 3875
    
    var date : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let dateWithTime = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        date = dateFormatter.string(from: dateWithTime)
        addCommentTextView.text = "## \(self.date) ()\n\n## やったこと \n+ \n+ \n+ \n\n## やること \n+ \n+ \n+ \n\n## 一言 \n+ \n+ \n+ "
        addCommentTextView.textColor = UIColor.black
        addCommentTextView.isScrollEnabled = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addCommentButtonPressed(_ sender: Any) {
        print("Pressed")
        if (addCommentTextView.text == ""){
            return
        }
        let comment = addCommentTextView.text
        postComment(commentString: comment!)
        
    }
    
    func postComment(commentString : String) {
        let jsonComment : [String: String] = [
            "body": commentString
        ]
        
        let jsonCommentData = try? JSONSerialization.data(withJSONObject: jsonComment)
        
        let url = URL(string: "https://api.github.com/repos/\(ownerName)/\(repositoryName)/issues/\(issueNumber)/comments")!
        let httpHeaderRequests = ["Authorization" : "token 8cb0f7220dfc3847fa6e048daa4031028339cb14","Accept" : "application/vnd.github.v3.text+json"]
        
        var request = URLRequest (url: url)
        request.httpMethod = "POST"
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
                    self.addCommentTextView.text = "## \(self.date) ()\n\n## やったこと \n+ \n+ \n+ \n\n## やること \n+ \n+ \n+ \n\n## 一言 \n+ \n+ \n+ "
                    let alertController = UIAlertController(title: "Post Sucessfull", message:
                        "Your comment was posted", preferredStyle: UIAlertControllerStyle.alert)
                    alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,handler: nil))
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
        task.resume()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
