//
//  LoginViewController.swift
//  Twitter
//
//  Created by Arasu Subramanian on 2/17/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: "userLoggedin") == true {
            self.performSegue(withIdentifier: "logintoHome", sender: self)
        }
            
    }
    
    @IBAction func onLoginButton(_ sender: Any) {
        
        let myURL = "https://api.twitter.com/oauth/request_token"
        UserDefaults.standard.set.(true, forKey: "user logged in")
        TwitterAPICaller.client?.login(url: myURL, success: {
            performSegue(withIdentifier: "loginToHome", sender: self)
        }, failure: { <#Error#> in
            print("Could not log in!")
        })
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
