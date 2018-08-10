//
//  ProfileTabViewController.swift
//  Dawat Nama
//
//  Created by MacBook Prp on 17/07/2018.
//  Copyright © 2018 Codiansoft. All rights reserved.
//

import UIKit

class ProfileTabViewController: UIViewController,TabSwiper {

    
    @IBOutlet weak var profileUI: UIView!
    
    @IBOutlet weak var detailView: UILabel!
    @IBOutlet weak var profileImage: DesignUIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profileEmail: UILabel!
    @IBOutlet weak var profileNumber: UILabel!
    
    //MARK: - UserDefault Image
    let imagesave = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Home Tab Loaded")
        InitSwipView(direction: .right )
        // Do any additional setup after loading the view.
        addTapgestureOfImage()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setimageSaved()
    }
    
    func HandleSwipe(_ Sender: UISwipeGestureRecognizer) {
        if Sender.direction == .right {
            
                self.tabBarController?.selectedIndex = 1
            
            
        }
    }
    func setimageSaved(){
        if let imageObj = imagesave.object(forKey:"saveImage") {
            print("setimageSaved true")
            let dataImage = imageObj as! NSData
            profileImage.image = UIImage(data: dataImage as Data)
        }else{
            print("setimageSaved false")

            profileImage.image = UIImage(named: "profile")
        }
        
        if imagesave.bool(forKey: "token"){
            let fetch  = imagesave.value(forKey: "LoggedIN") as! Dictionary<String,String>
            profileName.text = fetch["Name"]
            profileEmail.text = fetch["Email"]
            profileNumber.text = fetch["Phone"]
        }
    
    }
    
    private func addTapgestureOfImage(){
        let profileImagetap = UITapGestureRecognizer(target: self, action: #selector(tapMeUp))
        profileImage.isUserInteractionEnabled = true
        profileImage.addGestureRecognizer(profileImagetap)
    }
    
    @objc func tapMeUp(){
        print("image clicke")
        openGallery()
    }
    
    private func openGallery(){
        
        let imagepicker = UIImagePickerController()
        imagepicker.delegate = self
        imagepicker.allowsEditing = true
        imagepicker.sourceType = .photoLibrary
        imagepicker.modalPresentationStyle = .popover
        present(imagepicker, animated: true, completion: nil)
    }
  

}

extension ProfileTabViewController:UINavigationControllerDelegate,UIImagePickerControllerDelegate{
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print(info)
        guard let image = info[UIImagePickerControllerEditedImage] as? UIImage else {
            print("notimage")
            return
        }
        profileImage.contentMode = .scaleAspectFill
        profileImage.image = image
        let images = ["imageSet":image]
        let imageDecode = UIImageJPEGRepresentation(image, 1.0)! as NSData
        imagesave.set(imageDecode, forKey: "saveImage")
        
        NotificationCenter.default.post(name: NSNotification.Name("profileDataMain"), object: nil, userInfo: images)
        
        dismiss(animated: true, completion: nil)
    }
}
