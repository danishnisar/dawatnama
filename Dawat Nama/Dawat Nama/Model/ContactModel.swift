//
//  Contact.swift
//  Dawat Nama
//
//  Created by MacBook Prp on 01/08/2018.
//  Copyright © 2018 Codiansoft. All rights reserved.
//

import Foundation

class ContactModel {
    var CNName = ""
    var CNPhone = ""
    var CNImage = ""
    
    init(name:String,phone:String,image:String) {
        
        self.CNName = name
        self.CNPhone = phone
        self.CNImage = image
    }
    
    
}
