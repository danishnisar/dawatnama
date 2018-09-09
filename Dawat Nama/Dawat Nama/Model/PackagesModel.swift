//
//  PackagesModel.swift
//  Dawat Nama
//
//  Created by MacBook Prp on 04/09/2018.
//  Copyright © 2018 Codiansoft. All rights reserved.
//

import UIKit

class PackagesModel{
    
    var plan_id:String = "0"
    var name:String = "NoName"
    var price:String = "0"
    var readem_points:String = "0"
    
    init(plan_id:String,name:String,price:String,readem:String) {
        self.name = name
        self.plan_id = plan_id
        self.price = price
        self.readem_points = readem
    }
    
}
