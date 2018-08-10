//
//  DesignUIImageView.swift
//  Dawat Nama
//
//  Created by MacBook Prp on 09/08/2018.
//  Copyright © 2018 Codiansoft. All rights reserved.
//

import UIKit
@IBDesignable
class DesignUIImageView: UIImageView {

    @IBInspectable var imageRadius : Bool = false {
        didSet {
            upDateUI()
        }
    }
    
    private func upDateUI(){
        if imageRadius {
        layer.cornerRadius = layer.bounds.width/2
        layer.masksToBounds = true
        }
    }
}
