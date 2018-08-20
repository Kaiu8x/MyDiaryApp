//
//  CommentViewController.swift
//  desk
//
//  Created by Kai K on 6/12/18.
//  Copyright © 2018 Kaiu8x. All rights reserved.
//

import UIKit

class CommentViewController: UIViewController {

    @IBOutlet weak var comments: UILabel!
    @IBOutlet weak var editCommentButton: UIBarButtonItem!
    
    var comment: contentDict?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        comments.numberOfLines = 0
        
        comments.text = comment?.content
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func editCommentButtonPressed(_ sender: Any) {
        print("edit comment button pressed")
        performSegue(withIdentifier: "editCommentSegue", sender: self)
    }
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? EditCommentViewController {
            //print(comments.text)
            //print(comment?.id)
            let tempString : String = (comment?.title)!
            destination.changeText = "\(tempString) \n \n \(comments.text!)"
            
            destination.id = (comment?.id)!
            print("change segue")
            
        }
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
