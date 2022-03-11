//
//  FeedCellTableViewCell.swift
//  SozlukApp
//
//  Created by Muaz Talha Bulut on 10.03.2022.
//

import UIKit
import Firebase

class FeedCellTableViewCell: UITableViewCell {

   
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likesLabel: UILabel!
    
   //@IBOutlet weak var likesLabel: UILabel!
   @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var documentIdLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
       
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
    @IBAction func likeButton(_ sender: Any) {
        
        let fireStoreDataBase = Firestore.firestore()
       
        
        if let likeCount = Int(likesLabel.text!){
           
            let likeStore = ["likes": likeCount + 1] as [String: Any]
            fireStoreDataBase.collection("Posts").document(documentIdLabel.text!).setData(likeStore, merge: true)
        }
       
        
    }
    
}
