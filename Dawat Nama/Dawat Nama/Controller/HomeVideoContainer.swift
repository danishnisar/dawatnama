//
//  HomeVideoContainer.swift
//  Dawat Nama
//
//  Created by MacBook Prp on 07/09/2018.
//  Copyright © 2018 Codiansoft. All rights reserved.
//


import UIKit
import WebKit
class HomeVideoContainer: UIViewController, WKUIDelegate {
        
        var webView: WKWebView!
        
        override func loadView() {
            let webConfiguration = WKWebViewConfiguration()
            webView = WKWebView(frame: .zero, configuration: webConfiguration)
            webView.uiDelegate = self
            self.view = webView
        }
    
        override func viewDidLoad() {
            super.viewDidLoad()
            NotificationCenter.default.addObserver(self, selector: #selector(getVideoURL(notification:)), name: NSNotification.Name("getvideoURL"), object: nil)
        }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    @objc func getVideoURL(notification:Notification){
         let videourl = notification.userInfo!["video"] as! String
        print("notificationwork",videourl)
        showvideo(url: "https://www.google.com")
    }
    
    private func showvideo(url:String){
        if let myURL = URL(string:url) {
            let myRequest = URLRequest(url: myURL)
            webView.load(myRequest)
        }
    }
    
}
