//
//  DesignUITextField.swift
//  Dawat Nama
//
//  Created by MacBook Prp on 05/08/2018.
//  Copyright © 2018 Codiansoft. All rights reserved.
//if
import UIKit


@IBDesignable
class DesignUITextField: UITextField {

    @IBInspectable var leftImage : UIImage?{
        didSet{
            //updateUI()
        }
    }
    @IBInspectable var paddingView:CGFloat = 0{
        didSet{
            //updateUI()
        }
    }
    
    @IBInspectable var borderRadius:CGFloat = 0 {
        didSet{
           // layer.cornerRadius = borderRadius
        }
    }
    
    @IBInspectable var bottomBorder:Bool = false {
        didSet{
            updateUI()
        }
    }
    @IBInspectable var borderColor:UIColor = UIColor.clear{
        didSet{
            updateUI()
        }
    }
    
    
    private func updateUI(){
        if let image = leftImage {
            leftViewMode = .always
            
            let imageView  = UIImageView(frame: CGRect(x: paddingView, y: 0, width: 35, height: 35))
            imageView.image = image
            
            var width = paddingView + 20
            if borderStyle == UITextBorderStyle.none || borderStyle == UITextBorderStyle.line {
                width += 15
            }
            let viewImage = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 35))
            viewImage.addSubview(imageView)
            
            // BorderBottom
           
            if borderStyle == UITextBorderStyle.none && bottomBorder == true {
                
                let brline = borderColor
                let brMake = CALayer()
                let brWidths = CGFloat(2.0)
                brMake.borderColor = brline.cgColor
                brMake.borderWidth = brWidths
                brMake.frame = CGRect(x: 0, y: bounds.size.height - brWidths, width: bounds.size.width, height: bounds.size.height)
                layer.addSublayer(brMake)
                layer.masksToBounds = true
                
//                self.layer.shadowColor = borderColor.cgColor
//                self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
//                self.layer.shadowOpacity = 1.0
//                self.layer.shadowRadius = 0.0
            }
            leftView = viewImage
            
            attributedPlaceholder = NSAttributedString(string: placeholder != nil ? placeholder! : "", attributes: [NSAttributedStringKey.foregroundColor : tintColor])
        
        }
        
        
        
        
    }
   
}
