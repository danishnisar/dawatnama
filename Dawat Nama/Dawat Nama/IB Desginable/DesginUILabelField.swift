//
//  DesginUILabelField.swift
//  Dawat Nama
//
//  Created by MacBook Prp on 07/08/2018.
//  Copyright © 2018 Codiansoft. All rights reserved.
//

import UIKit

@IBDesignable
class DesginUILabelField: UILabel {

   
    @IBInspectable var layerRaduis:CGFloat = 0 {
        didSet{
            updateUI()
            
        }
    }
    
    private func updateUI(){

        layer.cornerRadius = layerRaduis
        

}
    
}
