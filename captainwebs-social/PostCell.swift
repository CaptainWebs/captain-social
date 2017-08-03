//
//  PostCell.swift
//  captainwebs-social
//
//  Created by Nurlan Isazade on 03/08/17.
//  Copyright © 2017 Nurlan Isazade. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {


    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var caption: UITextView!
    @IBOutlet weak var likesLbl : UILabel!
  
    


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


}
