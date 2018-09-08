//
//  PackgesTblVCell.swift
//  Dawat Nama
//
//  Created by MacBook Prp on 04/09/2018.
//  Copyright © 2018 Codiansoft. All rights reserved.
//

import UIKit

class PackgesTblVCell: UITableViewCell {

    @IBOutlet weak var mainviewShadow: UIView!
    @IBOutlet weak var packagetitle: UILabel!
    @IBOutlet weak var points: UILabel!
    @IBOutlet weak var prive: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

   
    override func layoutSubviews() {
        
        mainviewShadow.layer.cornerRadius = 5
        mainviewShadow.layer.shadowOpacity = 0.18
        mainviewShadow.layer.shadowOffset = CGSize(width: 0, height: 2)
        mainviewShadow.layer.shadowRadius = 2
        mainviewShadow.layer.shadowColor = UIColor.black.cgColor
        mainviewShadow.layer.masksToBounds = false
        
        
    }
    
}
