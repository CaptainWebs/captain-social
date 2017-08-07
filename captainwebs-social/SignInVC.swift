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
import SwiftKeychainWrapper

class SignInVC: UIViewController {


  
  @IBOutlet weak var emailField: UITextField!
  

  @IBOutlet weak var passwordField: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  
  
  }

  override func viewDidAppear(_ animated: Bool) {


   if let _ = KeychainWrapper.standard.string(forKey: "uid"){
    
      performSegue(withIdentifier: "goToFeed", sender: nil)
    
    }

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
        
        if user != nil{
        
          let userData = ["provider" : credential.provider]
        
          
          DataService.ds.createFirebaseDBUsers(uid: (user?.uid)! , userData: userData as! Dictionary<String, String>)
          KeychainWrapper.standard.set((user?.uid)!, forKey: "uid")
          self.performSegue(withIdentifier: "goToFeed", sender: nil)
        
        }
      
      }
  
  
  })
  
  
  
  
  }
  
  
  @IBAction func signInTapped(_ sender: UIButton) {
  
  
     if let email = emailField.text, let password = passwordField.text{
     
         Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
          
            if error == nil{
            
              print("Nurlan: Email user authenticated with Firebase")
              if user != nil{
              
                 let userData = ["provider" : user?.providerID]
        
          
                 DataService.ds.createFirebaseDBUsers(uid: (user?.uid)! , userData: userData as! Dictionary<String, String>)
        
                KeychainWrapper.standard.set((user?.uid)!, forKey: "uid")
                self.performSegue(withIdentifier: "goToFeed", sender: nil)
        
              }
              
            
            } else{
            
            Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
              
                if error != nil{
                
                  print("Nurlan: Unable to authenticate with Firebase using email")
                
                } else{
                
                  print("Nurlan: Successfully created a user on Firebase using email")
                  if user != nil{
        
                     let userData = ["provider" : user?.providerID]
        
          
                     DataService.ds.createFirebaseDBUsers(uid: (user?.uid)! , userData: userData as! Dictionary<String, String>)
                    KeychainWrapper.standard.set((user?.uid)!, forKey: "uid")
                    self.performSegue(withIdentifier: "goToFeed", sender: nil)
        
                  }
                
                }
              
              
            })
            
            }
          
          
         })
     
     
     }
  
  
  
  }
}

