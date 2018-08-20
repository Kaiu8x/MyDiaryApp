//
//  LogInViewController.swift
//  desk
//
//  Created by Kai K on 6/12/18.
//  Copyright © 2018 Kaiu8x. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {

    @IBOutlet weak var logInImg: UIImageView!
    @IBOutlet weak var gitHubOwnerNameTextField: UITextField!
    @IBOutlet weak var repositoryNameTextField: UITextField!
    @IBOutlet weak var issueNumberTextField: UITextField!
    @IBOutlet weak var searchButn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func searchButnPressed(_ sender: Any) {
        
        if(gitHubOwnerNameTextField.text! == "" || repositoryNameTextField.text! == "" || issueNumberTextField.text! == "" ) {
            print("Alert: Field Empty")
            //return
        }
        
//        let userName : String = gitHubUserNameTextField.text!
//        let repositoryName : String = repositoryTextField.text!
        
        print("Button pushed")
        
        let defaults = UserDefaults.standard
        defaults.set("\(gitHubOwnerNameTextField.text!)", forKey: "GitHubOwnerName")
        defaults.set("\(repositoryNameTextField.text!)", forKey: "RepositoryName")
        defaults.set(Int(issueNumberTextField.text!)!, forKey: "IssueNumber")
        
        performSegue(withIdentifier: "logInComplete", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("hey")
        if let destination = segue.destination as? MasterViewController {
            print("entered")
            destination.ownerName = gitHubOwnerNameTextField.text!
            destination.repositoryName = repositoryNameTextField.text!
            destination.issueNumber = Int(issueNumberTextField.text!)!
            //print(gitHubUserNameTextField.text!)
            //print(destination.userName)
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view
     roller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
