//
//  UploadViewController.swift
//  SozlukApp
//
//  Created by Muaz Talha Bulut on 7.03.2022.
//

import UIKit
import Firebase

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
    @IBAction func actionButtonClicked(_ sender: Any) {
        
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
