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

    override func viewDidLoad() {
        super.viewDidLoad()
      
        tableView.delegate = self
        tableView.dataSource = self

      
    }
  
    func numberOfSections(in tableView: UITableView) -> Int {

      return 1
   
    }
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

      return 3


    }
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

      return tableView.dequeueReusableCell(withIdentifier: "feedCell") as! PostCell
   

    }
  

  @IBAction func signOutTapped(_ sender: Any) {
  
      
    let _ = KeychainWrapper.standard.remove(key: "uid")
    try! Auth.auth().signOut()
    
    performSegue(withIdentifier: "goToSignIn", sender: nil)

  }
  

}
