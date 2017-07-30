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

class FeedVCV: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

  
  @IBAction func signOutTapped(_ sender: Any) {
  
  
    let _ = KeychainWrapper.standard.remove(key: "uid")
    try! Auth.auth().signOut()
    
    performSegue(withIdentifier: "goToSignIn", sender: nil)
    
    
    
  
  
  
  }

}
