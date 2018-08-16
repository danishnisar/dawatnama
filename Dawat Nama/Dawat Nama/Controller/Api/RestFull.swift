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
    
}
