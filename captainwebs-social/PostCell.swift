//
//  PostCell.swift
//  captainwebs-social
//
//  Created by Nurlan Isazade on 03/08/17.
//  Copyright © 2017 Nurlan Isazade. All rights reserved.
//

import UIKit
import Firebase

class PostCell: UITableViewCell {


    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var caption: UITextView!
    @IBOutlet weak var likesLbl : UILabel!
  
    
    var post: Post!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
  
    func configureCell(post: Post, img: UIImage?){
    
      self.post = post
      self.caption.text = post.caption
      self.likesLbl.text = "\(post.likes)"
      
      if img != nil{
      
        self.postImage.image = img

      }else{
      
        let ref = Storage.storage().reference(forURL: post.imageUrl)
        
        ref.getData(maxSize: 2 * 1024 * 1024, completion: {(data, error) in
        
          
          if error != nil{
          
            print("Nurlan: unable to retrive the image")
          
          }else{
          
            print("Image downloaded from firebase storage")
            if let imgData = data{
            
              if let img = UIImage(data: imgData){
              
                self.postImage.image = img
                FeedVCV.imageCache.setObject(img, forKey: post.imageUrl as NSString)
              
              }
            
            }
          
          }
        
        
        })
      
      
      
      }
    
    }


}
