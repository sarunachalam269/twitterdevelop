//
//  HomeTableTableViewController.swift
//  Twitter
//
//  Created by Arasu Subramanian on 2/17/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class HomeTableTableViewController: UITableViewController {
    
    
    
    var tweetArray = [NSDictionary]()
    var numberOfTweets: Int!
    
    let myRefreshControl = UIRefreshControl()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loadTweets()
        
        tableView.refreshControl = myRefreshControl
        
        myRefreshControl.addTarget(self, action: #selector(loadTweets), for: .valueChanged)

    }
    
    #objc func loadTweets(){
        
        numberOfTweets = 20
        
        let myURL = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        
        
        
        let myParams = ["count" = numberOfTweets]
        
        let user = tweetArray[indexPath.row]["text"]["user"] as! NSDictionary
        
        
        
        
        TwitterAPICaller.client?.getDictionariesRequest(url: myURL, parameters: myParams, success: {(tweets: <#[NSDictionary]#> in
            
                                                                                            
            self.tweetArray.removeAll()
                                                    
            for tweet in tweets {
                 
                  self.tweetArray.append(tweet)
            
        
            }
                                                                                                
            self.tableView.reloadData()
                                                                                    
            self.myRefreshControl.endRefreshing()
                                                                                                     }, failure: { <#Error#> in
            print("Could not retrieve tweets! oh no!!")
        })
        
        
        
        
    }
                                                        
    func loadMoreTweets(){
            
            let myURL = "https://api.twitter.com/1.1/statuses/home_timeline.json"
            
            numberOfTweets = numberOfTweets + 20
            
            let myParams = ["count" = numberOfTweets]
            
            TwitterAPICaller.client?.getDictionariesRequest(url: myURL, parameters: myParams, success: {(tweets: <#[NSDictionary]#> in
                
                                                                                                
                self.tweetArray.removeAll()
                                                        
                for tweet in tweets {
                     
                      self.tweetArray.append(tweet)
                
            
                }
                                                                                                    
                self.tableView.reloadData()
                                                                                        
                                                                                                         }, failure: { <#Error#> in
                print("Could not retrieve tweets! oh no!!")
            })
            
            
            
    }
                                                            
override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
                if indexPath.row + 1 == tweetArray.count(loadMoreTweet() {
                    loadMoreTweets()
                }
                
            }

    @IBAction func onLogout(_ sender: Any) {
        TwitterAPICaller.client?.logout()
        self.dismiss(animated: true, completion: nil)
        UserDefaults.standard.set(false, forKey: "userLoggedIn")
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetCellTableViewCell
        
        cell.userNameLabel.text = user["name"] as? String
        cell.tweetContent.text = tweetArray[indexPath.row]["text"] as! String
            let imageUrl = URL(string: (user["profile_image_url_https"] as? String)!)
            let data = try? Data(contentOf: imageUrl!)
            
        
        if let imageData = data {
                cell.profileImageView.image = UIImage[data: imageData]
        }
        return cell
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
            return tweetArray.count
    }

 

}
