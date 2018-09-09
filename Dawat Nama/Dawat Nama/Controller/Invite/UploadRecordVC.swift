//
//  UploadRecordVC.swift
//  Dawat Nama
//
//  Created by MacBook Prp on 15/08/2018.
//  Copyright © 2018 Codiansoft. All rights reserved.
//

import UIKit
import MobileCoreServices
import AVFoundation
import Photos
import Firebase
import FirebaseStorage
import ProgressHUD

class UploadRecordVC: UIViewController {

    @IBOutlet weak var videoAttachment: UIImageView!
    var videoUrl:NSURL?
    let storageRefrence = Storage.storage().reference()
    var checkVideohas = false
    
    var dataCollect:Dictionary = [String:String]()
   //var mymp4url:URL?
    override func viewDidLoad() {
        super.viewDidLoad()
        print(dataCollect)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func recordAction(_ sender: Any) {
        let imagepicker = UIImagePickerController()
        imagepicker.delegate = self
        imagepicker.sourceType = .camera
        imagepicker.showsCameraControls = true
        imagepicker.videoQuality = .typeLow
        imagepicker.mediaTypes = [kUTTypeMovie as String]
        imagepicker.videoMaximumDuration = 10.0
        present(imagepicker, animated: true, completion: nil)
        
    }
    
    @IBAction func uploadAction(_ sender: Any) {
        
        let imagepicker = UIImagePickerController()
        imagepicker.delegate = self
        imagepicker.sourceType = .photoLibrary
        imagepicker.mediaTypes = [kUTTypeMovie as String]
        imagepicker.allowsEditing = true
        imagepicker.videoMaximumDuration = 10
        present(imagepicker, animated: true, completion: nil)

    }
    
    @IBAction func closeView(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func videoSubmitAction(_ sender: Any) {
        
        if checkVideohas {
            
            if let url = videoUrl {
                self.firbaseVideoUpload(url: url as URL)
            }
            
        }
        else {
            
            let alertControl = UIAlertController(title: "Confrimation", message: "Do you want to skip this step?", preferredStyle: .alert)
            let actionYes = UIAlertAction(title: "YES", style: .default) { (uiaction) in
               
                
                self.dataCollect["video_name"] = "no_name"
                self.dataCollect["video_url"] = "no_video"
                
               
                self.performSegue(withIdentifier: "contact", sender: self)
               

                print("actionYes")
            }
            let actionNo = UIAlertAction(title: "NO", style: .default) { (uiaction) in
                print("actionNo")
            }
            alertControl.addAction(actionNo)
            alertControl.addAction(actionYes)
            present(alertControl, animated: true, completion: nil)
        }
        
        
        
        
        
        
    }
    
    
    private func firbaseVideoUpload(url:URL){
        let timestamp = NSDate().timeIntervalSince1970
        let myTimeInterval = TimeInterval(timestamp)
        let time = NSDate(timeIntervalSince1970: TimeInterval(myTimeInterval))
        let name = "invoteVideoiOS-\(time).mp4"
        
        let VideoFolder = self.storageRefrence.child("videos/\(name)")
        
        let uploadTask = VideoFolder.putFile(from: url, metadata: nil, completion: { (metadata, error) in
            
            guard let metadata = metadata else {
                
                //ohh error
                return
            }
            print("metadata",metadata)
            
            VideoFolder.downloadURL(completion: { (url, error) in
                guard let downloadURL = url else {
                    //erroe
                    return
                }
                print("download url",downloadURL)
                let stringURL = "\(downloadURL)"
                self.dataCollect["video_name"] = "no_name"
                self.dataCollect["video_url"] = stringURL
                
                self.performSegue(withIdentifier: "contact", sender: self)
            })
            
            
        })
        uploadTask.observe(.progress, handler: { (snapshoot) in
            print(snapshoot.progress?.completedUnitCount ?? "novalue")
            if let progressCount = snapshoot.progress?.completedUnitCount {
                            ProgressHUD.show("Uploading \(progressCount)")
            }

            
        })
        uploadTask.observe(.success, handler: { (snapsoot) in
            uploadTask.removeAllObservers()
            ProgressHUD.showSuccess("Uploading Complete")
            
        })
        ProgressHUD.dismiss()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "contact" {
            let vc = segue.destination as! ThirdContactViewController
            vc.dataCollect = self.dataCollect
        }
    }
    
    
    
    
    // MARK: AVFoundation
    func exportVideoToMP4(url: URL, _ completion: @escaping ((URL?) -> Void)) {
        
        // Show some sort of indicator here, as this could take a while
        
        // Generate a temporary URL path to export the video
        let relativePath = "myAppTempVideoExport.mp4";
        let outputFilePath = NSTemporaryDirectory() + relativePath;
        
        print("Temp file path: \(outputFilePath)")
        
        
        // If there's any temp file from before at that path, delete it
        if FileManager.default.fileExists(atPath: outputFilePath) {
            do {
                try FileManager.default.removeItem(atPath: outputFilePath)
            }
            catch {
                print("ERROR: Can't remove temporary file from before. Cancelling export.")
                completion(nil)
                return
            }
        }
        
        
        // Export session setup
        let outputFileURL = URL(fileURLWithPath: outputFilePath)
        
        let asset = AVAsset(url: url) // Original (source) video
        // The original video codec is probably HEVC, so we'll force the system to re-encode it at the highest quality in MP4
        // You probably want to use medium quality if this video is intended to be uploaded (as this example is doing)
        if let exportSession = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetHighestQuality) {
            
            exportSession.outputURL = outputFileURL
            exportSession.outputFileType = .mp4
            
            exportSession.exportAsynchronously {
                
                // Hide the indicator for the export session
                switch exportSession.status {
                case .completed:
                    print("Video export completed.")
                    completion(outputFileURL)
                    return
                    
                case .failed:
                    print("ERROR: Video export failed. \(exportSession.error!.localizedDescription)")
                    completion(nil)
                    return
                    
                case .cancelled:
                    print("Video export cancelled.")
                    completion(nil)
                    return
                    
                default:
                    break
                }
                
            }
            
        }
        else {
            print("ERROR: Cannot create an AVAssetExportSession.")
            return
        }
        
    }
    
    
    
}

extension UploadRecordVC:UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let mediaType = info[UIImagePickerControllerMediaType] as? String {
         
            
            if mediaType == "public.movie" {
                print("Video Selected")
                print(info)
                if let url = info[UIImagePickerControllerMediaURL] as? NSURL {
                    //videoUrl = url
                    checkVideohas = true
                    DispatchQueue.global().async {
                        let asset = AVAsset(url: url as URL)
                        let assetImgGenerate : AVAssetImageGenerator = AVAssetImageGenerator(asset: asset)
                        assetImgGenerate.appliesPreferredTrackTransform = true
                        let time = CMTimeMake(1, 2)
                        let img = try? assetImgGenerate.copyCGImage(at: time, actualTime: nil)
                        if img != nil {
                            let frameImg  = UIImage(cgImage: img!)
                            DispatchQueue.main.async(execute: {
                                self.videoAttachment.image = frameImg
                                
                                self.exportVideoToMP4(url: url as URL, { (exportURL) in
                                    if let export = exportURL{
                                        self.videoUrl = export as NSURL
                                    }else{
                                        print("exportURL is nil")
                                    }
                                })
                            })
                        }
                        //MARK: - Video Save
                        if picker.sourceType != .photoLibrary{
                            PHPhotoLibrary.shared().performChanges({
                                PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: url as URL)
                            }) { saved, error in
                                if saved {
                                    let alertController = UIAlertController(title: "Your video was successfully saved", message: nil, preferredStyle: .alert)
                                    let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                                    alertController.addAction(defaultAction)
                                    self.present(alertController, animated: true, completion: nil)
                                }
                            }
                        }
                    }
                }else {
                    checkVideohas = false
                }
               
            }
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
}
