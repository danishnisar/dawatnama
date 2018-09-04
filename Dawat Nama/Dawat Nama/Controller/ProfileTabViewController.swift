//
//  ProfileTabViewController.swift
//  Dawat Nama
//
//  Created by MacBook Prp on 17/07/2018.
//  Copyright © 2018 Codiansoft. All rights reserved.
//

import UIKit
import Alamofire
import ProgressHUD
import SwiftyJSON

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
        self.profileImage.contentMode = .scaleAspectFill
        
        if let imageObj = imagesave.object(forKey:"saveImage") {
            profileImage.image = UIImage(data: imageObj as! Data)
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
        
        
        dismiss(animated: true){
            self.updateProfileImage(img:image)
        }
        
    }
    
    
    func updateProfileImage(img:UIImage){
        
        let alertconfirmation = UIAlertController(title: "Confirmation", message: "Do you want to update your profile image", preferredStyle: .alert)
        
        let actionNo = UIAlertAction(title: "No", style: .destructive) { (cancel) in
            
            print("no to update")
        }
        let actionYes = UIAlertAction(title: "Yes", style: .default) { (upload) in
            
            ProgressHUD.show("Uploading")
            let imageDecode = UIImageJPEGRepresentation(img, 1.0)! as NSData
            let base64string = imageDecode.base64EncodedString(options: NSData.Base64EncodingOptions.lineLength64Characters)
            
            //print("base64",base64string)
            /*
             
             user_id,
             image,
             extension
             
             */
            let userinfo = self.imagesave.value(forKey: "LoggedIN") as! Dictionary<String,String>
            let param = ["user_id":userinfo["ID"]!,"image":base64string,"extension":"jpg"] as [String : Any]
            Alamofire.request(RestFull.updateProfileimage,method: .post, parameters: param).responseJSON(completionHandler: { (response) in
                
                if let err = response.result.error{
                    ProgressHUD.showError("Uploading Failed")
                    print(err.localizedDescription)
                    ToastView.shared.short(self.view, txt_msg: "Internet connectivity issue")
                    ProgressHUD.dismiss()
                    return
                }
                ProgressHUD.dismiss()
                //let dataextract = JSON(response.result.value!)
                ProgressHUD.showSuccess("profile Updated")
                
                self.profileImage.image = img
                let images = ["imageSet":imageDecode]
                NotificationCenter.default.post(name: NSNotification.Name("profileDataMain"), object: nil, userInfo: images)
                
            })
            
            
        }
        alertconfirmation.addAction(actionNo)
        alertconfirmation.addAction(actionYes)
        
        present(alertconfirmation, animated: true, completion: nil)
        
    }
    
    
}
