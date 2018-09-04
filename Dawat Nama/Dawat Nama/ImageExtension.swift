//
//  ImageExtension.swift
//  Dawat Nama
//
//  Created by MacBook Prp on 03/09/2018.
//  Copyright © 2018 Codiansoft. All rights reserved.
//

import UIKit

var imgCache = NSCache<NSString,UIImage>()
extension UIImageView {
    
    func loadCacheImage(imgUrl:String){
        
        
        if let imgset = imgCache.object(forKey: imgUrl as NSString){
            self.image = imgset
            print("imgcache = \(imgset)")
            return
        }
        
        let url = URL(string: imgUrl)!
        //let url = URL(fileURLWithPath: img)
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if error != nil{
                print("Error = \(error!)")
                return
            }
            DispatchQueue.main.async {
                print(data!)
                
                if let imgget = UIImage(data:data!){
                    imgCache.setObject(imgget, forKey: imgUrl as NSString)
                    self.image = imgget;
                    
                    
                    
                }
                
                
            }
            
            
        }).resume()
    }
    
    
}

