//
//  FeedVCV.swift
//  captainwebs-social
//
//  Created by Nurlan Isazade on 30/07/17.
//  Copyright © 2017 Nurlan Isazade. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class FeedVCV: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView : UITableView!
  
    var posts = [Post]()

    override func viewDidLoad() {
        super.viewDidLoad()
      
        tableView.delegate = self
        tableView.dataSource = self
      
        DataService.ds.REF_POSTS.observe(.value, with: { (snapshot) in
          
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot]{
            
              for snap in snapshot{
              
                print("Snap: \(snap)")
                if let postDict = snap.value as? Dictionary<String, AnyObject>{
                
                  let key = snap.key
                  let post = Post(postKey: key, postData: postDict)
                  self.posts.append(post)
                
                }
              
              }
      
            }
            self.tableView.reloadData()
          
        })
      
}
  
    func numberOfSections(in tableView: UITableView) -> Int {

      return 1
   
    }
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

      return posts.count


    }
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
      let post = posts[indexPath.row]
      print("Nurlan: \(post.caption)")

      return tableView.dequeueReusableCell(withIdentifier: "feedCell") as! PostCell
   

    }
  

  @IBAction func signOutTapped(_ sender: Any) {
  
      
    let _ = KeychainWrapper.standard.remove(key: "uid")
    try! Auth.auth().signOut()
    
    performSegue(withIdentifier: "goToSignIn", sender: nil)

  }
  

}
