//
//  UploadViewController.swift
//  SozlukApp
//
//  Created by Muaz Talha Bulut on 7.03.2022.
//

import UIKit
import Firebase
import FirebaseStorage

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var commentText: UITextField!
    @IBOutlet weak var ımageView: UIImageView!
    @IBOutlet weak var uploadButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        ımageView.isUserInteractionEnabled = true // tıklanılabilir hale getirdik
        let gestureRecognizer =  UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        ımageView.addGestureRecognizer(gestureRecognizer)
   
    
    
    }
    
    func makeAlert(titleInput: String, Message: String) {
        let alert = UIAlertController(title: titleInput, message: Message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func actionButtonClicked(_ sender: Any) {
        
        let storage = Storage.storage()
        let storageReference = storage.reference()
        
        let mediaFolder = storageReference.child("media")
        
        if let data = ımageView.image?.jpegData(compressionQuality: 0.5) {
            
            let uuid = UUID().uuidString
            
            let imageReference = mediaFolder.child("\(uuid).jpeg")
            imageReference.putData(data, metadata: nil) { (metadata, error) in
                if error != nil {
                    self.makeAlert(titleInput:"Error!", Message: error?.localizedDescription ?? "Error")
                }else{
                    
                    imageReference.downloadURL { (url, error) in
                        if error == nil {
                            let imageUrl = url?.absoluteString
                            print(imageUrl)
                            
                            //DATABASE
                            
                            let firestoreDatabase = Firestore.firestore()
                            var firestoreReference: DocumentReference? = nil
                            let firestorePost = ["imageUrl": imageUrl!, "postedBy": Auth.auth().currentUser!.email!, "postComment": self.commentText.text!, "date": FieldValue.serverTimestamp()    , "likes": 0] as [String : Any]
                            
                            
                            firestoreReference = firestoreDatabase.collection("Posts").addDocument(data: firestorePost, completion: { (error) in
                                if error != nil {
                                    self.makeAlert(titleInput: "Error!", Message: error?.localizedDescription ?? "Error ")
                                }else{
                                    
                                    self.ımageView.image = UIImage(named: "png-clipart-computer-mouse-pointer-button-point-and-click-computer-mouse-electronics-text")
                                    self.commentText.text = ""
                                    self.tabBarController?.selectedIndex = 0
                                    
                                }
                            })
                        }
                    }
                }
            }
        }
        
        
        
    }
    
    // kuallnıı daatyı seçince ne olacak??
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        ımageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }

    @objc func chooseImage() {
        
        // kullanıcının kütüphanesi ulaşalım
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary // datayı nereden alsın????
        present(pickerController, animated: true, completion: nil)
    }

}
