//
//  AuthVC.swift
//  Dawat Nama
//
//  Created by MacBook Prp on 03/08/2018.
//  Copyright © 2018 Codiansoft. All rights reserved.
//

import UIKit

class ContainerAuthVC: UIViewController {

    @IBOutlet weak var scrollViewUpdate: UIScrollView!
    @IBOutlet weak var segementAuth: UISegmentedControl!
    
    @IBOutlet weak var loginVC: UIView!
    
    @IBOutlet weak var RegisterVC: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //MARK: - Segment Default Selected
        defaultSegmentIndexSelected()
        
        //MARK: - Register Notifcation Center
        registerNotifcationCenter()
        
        
    }

   
    
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    private func defaultSegmentIndexSelected(){
        RegisterVC.alpha = 0
        //segementAuth.selectedSegmentIndex = 0
    }
    
    
    @objc func updateKeyboard(){
        print("updateKeyboard")
        scrollViewUpdate.setContentOffset(CGPoint(x: 0, y: 100), animated: true)
    }
    @objc func registerupdateKeyboard(){
            print("registerupdateKeyboard")
        scrollViewUpdate.setContentOffset(CGPoint(x: 0, y: 250), animated: true)
    }
    
    @objc func authDownKey(){
        scrollViewUpdate.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        
    }
    @IBAction func segmenuAuthAction(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            RegisterVC.alpha = 0
            loginVC.alpha = 1
            
            print(sender.selectedSegmentIndex)
        }else{
            RegisterVC.alpha = 1
            loginVC.alpha = 0
            print(sender.selectedSegmentIndex)
        }
        
    }
    
    private func registerNotifcationCenter(){
        NotificationCenter.default.addObserver(self, selector: #selector(updateKeyboard), name: NSNotification.Name("LoginKeyUp"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(registerupdateKeyboard), name: NSNotification.Name("RegisKeyUp"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(authDownKey), name: NSNotification.Name("KeyDown"), object: nil)
        
    }

}
