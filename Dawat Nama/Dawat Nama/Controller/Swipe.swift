//
//  Swiping.swift
//  Dawat Nama
//
//  Created by MacBook Prp on 17/07/2018.
//  Copyright © 2018 Codiansoft. All rights reserved.
//

import UIKit

@objc protocol TabSwiper {
    func HandleSwipe(_ Sender:UISwipeGestureRecognizer)
}

extension TabSwiper where Self:UIViewController {
    
    func InitSwipView(direction:UISwipeGestureRecognizerDirection ){
       
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(HandleSwipe(_:)))
        swipe.direction = direction
        self.view.addGestureRecognizer(swipe)
       
    }
    
}
