//
//  TblBaseHome.swift
//  Dawat Nama
//
//  Created by MacBook Prp on 19/07/2018.
//  Copyright © 2018 Codiansoft. All rights reserved.
//

import UIKit

class TblBaseHome: UITableViewCell {

    @IBOutlet weak var MainViewBG: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        addShadow()
    }
    
 
    func addShadow(){
        
       MainViewBG.layer.cornerRadius = 5
        MainViewBG.layer.shadowOpacity = 0.18
        MainViewBG.layer.shadowOffset = CGSize(width: 0, height: 2)
        MainViewBG.layer.shadowRadius = 2
        MainViewBG.layer.shadowColor = UIColor.black.cgColor
        MainViewBG.layer.masksToBounds = false
    }
}
