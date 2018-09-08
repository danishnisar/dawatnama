//
//  SendReceiptVC.swift
//  Dawat Nama
//
//  Created by MacBook Prp on 04/09/2018.
//  Copyright © 2018 Codiansoft. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ProgressHUD

class SendReceiptVC: UIViewController {

    @IBOutlet weak var imageUpload: UIImageView!
    //ImagepickerController
    let imagepicker = UIImagePickerController()
    var checkthImage = false
    var imageSet:UIImage?
    let userinfo = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
        // Do any additional setup after loading the view.
        
        
        tapImageclickable()
    }

    //MARK: - ImageClickable Upload
    private func tapImageclickable(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openGalleryOrCamera))
        imageUpload.isUserInteractionEnabled = true
        imageUpload.addGestureRecognizer(tapGesture)
        
    }

    //MARK: - Choose in action sheet Camera or gallery to Upload image
   @objc private func openGalleryOrCamera(){

        let actionsheet = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        let camera = UIAlertAction(title: "Take Photo", style: .default) { (camera) in
            print("takephoto")
            self.openCamera()
        }
        
        let gallery = UIAlertAction(title: "Choose Photo", style: UIAlertActionStyle.default) { (gallery) in
            print("choosePhoto")
            self.openGallery()
        }
    
    let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { (cancel) in
        print("cancel")
    }
        
        actionsheet.addAction(gallery)
        actionsheet.addAction(camera)
        actionsheet.addAction(cancel)
        present(actionsheet, animated: true, completion: nil)
        
    }
    
    private func openCamera(){
        imagepicker.delegate = self
        imagepicker.sourceType = .camera
        imagepicker.allowsEditing = true
        present(imagepicker, animated: true, completion: nil)
    }
    private func openGallery(){
            imagepicker.delegate = self
            imagepicker.sourceType = .photoLibrary
            imagepicker.allowsEditing = true
            present(imagepicker, animated: true, completion: nil)
    }
    
    @IBAction func quiteSendreceipt(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func uploadAction(_ sender: UIButton) {
        
        if checkthImage {
            
            //networking start
            /*
             
             user_id,
             image,
             extension
             
             */
            
            ProgressHUD.show("Uploading..")
            if let imageSelected = imageSet {
                let imageDecode = UIImageJPEGRepresentation(imageSelected, 1.0)! as NSData
                let base64string = imageDecode.base64EncodedString(options: NSData.Base64EncodingOptions.lineLength64Characters)
                
                let UserINFO = userinfo.value(forKey: "LoggedIN") as! Dictionary<String,String>
                let param = ["user_id":UserINFO["ID"]!,"image":base64string,"extension":"jpg"] as [String : Any]
                
                //print("base64",base64string)
                
                
                Alamofire.request(RestFull.sendpackageImage,method: .post, parameters: param).responseJSON(completionHandler: { (response) in
                    
                    if let err = response.result.error{
                        ProgressHUD.showError("Uploading Failed")
                        print(err.localizedDescription)
                        ToastView.shared.short(self.view, txt_msg: "Internet connectivity issue")
                        ProgressHUD.dismiss()
                        return
                    }
                    
                    let dataextract = JSON(response.result.value!)
                    if let success = dataextract["result"]["status"].string {
                        if success == "success" {
                            
                            //print(dataextract["result"]["status"])
                            ProgressHUD.showSuccess("Receipt Sent.")
                            self.imageUpload.image = UIImage(named: "attachment")
                            
                        }
                        else{
                            print("something issue")
                        }
                    }else{
                        print("something issue main")
                    }
                    ProgressHUD.dismiss()
                  
                    
                })
                
                
                
            }else{
                print("Image not saved in from picker section ")
            }
            
           
            
            
        }else {
            
            openGalleryOrCamera()
            
        }
        
        
    }


}

extension SendReceiptVC:UINavigationControllerDelegate,UIImagePickerControllerDelegate {

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let photo = info[UIImagePickerControllerEditedImage] as? UIImage {
            imageUpload.image = photo
            self.checkthImage = true
            imageSet = photo
        }else{
            print("error in picker controller")
        }
        
        self.dismiss(animated: true){}
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("cancel by user")
    }
}
