//
//  TblBaseCellView.swift
//  Dawat Nama
//
//  Created by MacBook Prp on 17/07/2018.
//  Copyright © 2018 Codiansoft. All rights reserved.
//

import UIKit

class TblBaseCellView: UITableViewCell {

    @IBOutlet weak var mainview: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var invitesender: UILabel!
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var eventDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    override func layoutSubviews() {
        
        mainview.layer.cornerRadius = 5
        mainview.layer.shadowOpacity = 0.18
        mainview.layer.shadowOffset = CGSize(width: 0, height: 2)
        mainview.layer.shadowRadius = 2
        mainview.layer.shadowColor = UIColor.black.cgColor
        mainview.layer.masksToBounds = false
        
        
    }

  
    
}
