//
//  RestFull.swift
//  Dawat Nama
//
//  Created by MacBook Prp on 07/08/2018.
//  Copyright © 2018 Codiansoft. All rights reserved.
//

import Foundation

class RestFull {
    
    
    
    private static var hostURL = "https://dawatnama.com/marriage"
    
    //Login URL
    static let loginURL = RestFull.hostURL+"/api/login"
    
    //Register URL
    static let registerURL = RestFull.hostURL+"/api/register"
    
    //FETCH INVITATIONS: (POST)
    static let fetchInvitationURL = RestFull.hostURL+"/api/fetch_invitations"

    static let fetch_perInvitation = RestFull.hostURL+"/api/per_invitation"
    
    static let fetch_Event = RestFull.hostURL+"/api/get_events"
    
    static let post_Invitation = RestFull.hostURL+"/api/invitations"
    
    static let updateProfileimage = RestFull.hostURL+"/api/update_user_image"
    
    static let sendpackageImage = RestFull.hostURL+"/api/send_receipt"

    //FETCH WALLET PACKAGES: (GET)
    static let fetchWallet = RestFull.hostURL+"/api/packages"
    
    //FETCH UPCOMING EVENTS: (POST)
    static let fetchUpcommingEvents = RestFull.hostURL+"/api/fetch_upcoming_events"
   // inputs: sender_id, phone_number
   // output: same data as FETCH INVITATIONS

    //FETCH UPCOMING EVENTS: (POST)
    static let fetchEventsContact = RestFull.hostURL+"/api/fetch_contacts"
    
    //ResendInvitation
    static let resendEventsContact = RestFull.hostURL+"/api/resend_invitation"
    
    
}
