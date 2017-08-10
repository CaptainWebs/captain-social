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
import Foundation


class FeedVCV: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var tableView : UITableView!
    var imagePicker: UIImagePickerController!
  
  @IBOutlet weak var imageAdd: UIImageView!
    var posts = [Post]()
  
    static var imageCache: NSCache<NSString, UIImage> = NSCache()

    override func viewDidLoad() {
        super.viewDidLoad()
      
        tableView.delegate = self
        tableView.dataSource = self
      
        imagePicker = UIImagePickerController()
      
        imagePicker.allowsEditing = true
      
        imagePicker.delegate = self
      
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
  
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
  
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage{
        
          imageAdd.image = image
        
        } else{
        
          print("Nurlan: A valid image was not found")
        
        }

        imagePicker.dismiss(animated: true, completion: nil)
  
      }
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
      let post = posts[indexPath.row]
      
      if let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell") as? PostCell{
      
        
        if let img = FeedVCV.imageCache.object(forKey: post.imageUrl as NSString){
        
          cell.configureCell(post: post, img: img)
          return cell
        
        }else{
         
         cell.configureCell(post: post, img: nil)
         return cell
        
        }
        
      
      }else{
      
        return PostCell()
      
      }

 
    }
  
  @IBAction func addImageTapped(_ sender: Any) {
  

    present(imagePicker, animated: true, completion: nil)
  
  }

  @IBAction func signOutTapped(_ sender: Any) {
  
      
    let _ = KeychainWrapper.standard.remove(key: "uid")
    try! Auth.auth().signOut()
    
    performSegue(withIdentifier: "goToSignIn", sender: nil)

  }
  

}
