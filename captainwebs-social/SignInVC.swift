//
//  ViewController.swift
//  captainwebs-social
//
//  Created by Nurlan Isazade on 29/07/17.
//  Copyright © 2017 Nurlan Isazade. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase

class SignInVC: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


  @IBAction func fbButtonTapped(_ sender: Any) {
  
    let facebookLogin = FBSDKLoginManager()
    
    facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
      
      if error != nil{
      
        print("Nurlan: An error happened - \(String(describing: error))")
      
      } else if result?.isCancelled == true{
      
        print("Nurlan: User cancelled authentication")
      
      } else{
      
        print("Successfully authenticated")
        let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        
        self.firebaseAuth(credential)
  
      }
      
      
    }
  
  }
  
  func firebaseAuth(_ credential: AuthCredential){
  
    Auth.auth().signIn(with: credential, completion: {(user,error) in
  
      if error != nil{
      
        print("An Error happened")
      
      } else {
      
        print("Successfully authenticated with Firebase")
      
      }
  
  
  
  
  
  })
  
  
  
  
  }
}

