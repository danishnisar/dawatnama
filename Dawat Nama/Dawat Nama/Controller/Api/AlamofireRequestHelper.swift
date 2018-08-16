//
//  AlamofireRequestHelper.swift
//  Dawat Nama
//
//  Created by MacBook Prp on 11/08/2018.
//  Copyright © 2018 Codiansoft. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class AlamofireRequestHelper{
    
    
    lazy var jsonDATA:JSON = "";
    lazy var condCheck:Bool = false

     func fire(url:String,method:HTTPMethod,param:[String:String]) -> (JSON,Bool){
        
        
        Alamofire.request(url, method: method, parameters: param).responseJSON { (response) in
            if response.result.isSuccess {
                let data = JSON(response.result.value!)
                self.jsonDATA = data
                self.condCheck = true
                
            }
            else{
                let err = response.result.error!
                let data = JSON(err)
                self.jsonDATA = data
                self.condCheck = false
                
            }
        }
        return (self.jsonDATA,self.condCheck)
    }
    
}
