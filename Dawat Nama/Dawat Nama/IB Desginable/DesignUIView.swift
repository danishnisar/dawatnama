//
//  DesignUIView.swift
//  Dawat Nama
//
//  Created by MacBook Prp on 10/08/2018.
//  Copyright © 2018 Codiansoft. All rights reserved.
//

import UIKit
@IBDesignable
class DesignUIView: UIView {

    @IBInspectable var RadiusAndShadow:Bool = false {
        didSet{
            updateUI()
        }
    }
    @IBInspectable var backgrouImage:UIImage? {
        didSet{
            updateUI()
        }
    }
    
    private func updateUI(){
        
        if RadiusAndShadow {
            layer.cornerRadius = 5
            layer.shadowOpacity = 0.18
            layer.shadowOffset = CGSize(width: 0, height: 2)
            layer.shadowRadius = 2
            layer.shadowColor = UIColor.black.cgColor
            layer.masksToBounds = false
        }
        if let image = backgrouImage {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height))
        imageView.image = image
        self.addSubview(imageView)
        }
        
    }
    

}
