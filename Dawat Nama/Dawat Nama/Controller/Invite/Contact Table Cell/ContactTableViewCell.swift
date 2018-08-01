//
//  ContactTableViewCell.swift
//  Dawat Nama
//
//  Created by MacBook Prp on 01/08/2018.
//  Copyright © 2018 Codiansoft. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var CNName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
