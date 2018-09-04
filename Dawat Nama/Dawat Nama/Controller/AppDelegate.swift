//
//  AppDelegate.swift
//  Dawat Nama
//
//  Created by MacBook Prp on 12/07/2018.
//  Copyright © 2018 Codiansoft. All rights reserved.
//

import UIKit
import Firebase
import GooglePlaces
import GoogleMaps
import FirebaseMessaging
import UserNotifications
import SwiftyJSON

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,MessagingDelegate,UNUserNotificationCenterDelegate {

    var window: UIWindow?
    var instanceIDTokenMessage = ""
    let fcm = UserDefaults.standard
    var countbadge = 0
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        GMSPlacesClient.provideAPIKey("AIzaSyDkme1rkM3rCagSH1RIjjoa1wwHD1UvUfE")
        GMSServices.provideAPIKey("AIzaSyDkme1rkM3rCagSH1RIjjoa1wwHD1UvUfE")
        
        
        
        if #available(iOS 10.0, *) {
            
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {issucess, error in
                    if let err = error {
                        print(err.localizedDescription)
                    }
            })
            
            
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        Messaging.messaging().delegate = self
        application.registerForRemoteNotifications()
        UIApplication.shared.applicationIconBadgeNumber = 0
        
        if #available(iOS 10.0, *) {
//            let fruitaction  = UNNotificationAction(identifier: "Open", title: "Add a piece of frot", options: [])
            let Okay  = UNNotificationAction(identifier: "open", title: "View", options: [])
            let cateogry = UNNotificationCategory(identifier: "food", actions: [Okay], intentIdentifiers: [], options: [])
            UNUserNotificationCenter.current().setNotificationCategories([cateogry])
        } else {
            // Fallback on earlier versions
        }
        
        
        return true
    }

    
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        Messaging.messaging().shouldEstablishDirectChannel = false
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
         UIApplication.shared.applicationIconBadgeNumber = 0
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        connectFCM(cond:true)
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        let userINFO = UserDefaults.standard
        userINFO.removeObject(forKey: "ResultCount")
    }


    //Called When Registration for Remote Notifcation is Succssful
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    
        Messaging.messaging().apnsToken = deviceToken
        InstanceID.instanceID().instanceID { (result, error) in
                if let error = error {
                    print("Error fetching remote instange ID: \(error)")
                } else if let result = result {
                    print("Remote instance ID token: \(result.token)")
                    self.instanceIDTokenMessage = result.token
                    self.fcm.set(result.token as String, forKey: "fcmtoken")
                    
                }
            }
    }
    //Called When Registration for Remote Notifcation is Failed
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Registerd Failed")
    }
    
    //Called When cloud Message Arrives while app is in forground
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        //Custome code to handle push while app is in forgoround
        print("Handle push from forground \(notification.request.content.userInfo)")
        
        //Ready message body
//        let dict = notification.request.content.userInfo["aps"] as! NSDictionary
//
//        var messageBody:String?
//        var messageTitle:String = "Alert"
//
//        if let alertDict = dict["alert"] as? Dictionary<String,String>{
//            messageBody = alertDict["body"]!
//            if alertDict["title"] != nil { messageTitle = alertDict["title"]! }
//        }else{
//            messageBody = dict["alert"]  as? String
//        }
//
//        print("Message body \(messageBody)")
//        print("Message Title \(messageTitle)")
        
        //lets iOS to display message
        
        completionHandler([.alert,.sound,.badge])
    }
    
    //Called When cloud Message Arrives while app is in forground
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        print("Message \(response.notification.request.content.userInfo)")
        
        completionHandler()
    }
    
    
    
    //Called when silent push notication arrives
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        
        Messaging.messaging().appDidReceiveMessage(userInfo)
        
        print("Entire Message \(userInfo)")
      //  connectFCM(cond:true)
        let state: UIApplicationState = application.applicationState
        switch state {
        case UIApplicationState.active:
            
            print("if need notify user about the message")
        default:
            
            if #available(iOS 10.0, *) {
                UIApplication.shared.applicationIconBadgeNumber += 1
                let content  = UNMutableNotificationContent()
                content.title = (userInfo["status"] as! String == "650") ? "Alert" : "Invitaion"
                content.body = userInfo["message"] as! String
                content.sound = UNNotificationSound.default()
                content.categoryIdentifier = "food"
               
                let request = UNNotificationRequest(identifier: "foodNotifcation", content: content, trigger: nil)
                UNUserNotificationCenter.current().removeAllDeliveredNotifications()
                UNUserNotificationCenter.current().add(request) { (error) in
                    if let err = error {
                        print("error \(err)")
                    }
                }
            } else {
                // Fallback on earlier versions
            }
            
            print("rund code to download content")
        }
        
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("registerationtoken",fcmToken)
        
    }
    
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        print(remoteMessage.appData)
        
       
    }
    
    func connectFCM(cond:Bool){
        Messaging.messaging().shouldEstablishDirectChannel = true
    }
  
    
    
}

