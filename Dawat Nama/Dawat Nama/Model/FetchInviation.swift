//
//  FetchInviation.swift
//  Dawat Nama
//
//  Created by MacBook Prp on 09/08/2018.
//  Copyright © 2018 Codiansoft. All rights reserved.
//

import Foundation

class FetchInviation{
    var invitation_type = ""
    var host_1 = ""
    var venue_name = ""
    var rsvp_name_3 = ""
    var video_url = ""
    var invitation_count = ""
    var host_2_parent = ""
    var din_time = ""
    var rsvp_number_3 = ""
    var host_2 = ""
    var sender_id = ""
    var event_name = ""
    var id = ""
    var rsvp_name_1 = ""
    var new_video_url = ""
    var event_date = ""
    var invitation_limit = ""
    var image_url = ""
    var rsvp_number_1 = ""
    var rsvp_number_2 = ""
    var rsvp_name_4 = ""
    var sender_name = ""
    var rsvp_number_4 = ""
    var event_cat_id = ""
    var gender = ""
    var date = ""
    var rsvp_name_2 = ""
    var host_1_parent = ""
    var location = ""
    var arr_time = ""
    var time_label = ""
    var invitation_side = ""
    
    init(invitation_type:String,
        host_1:String,venue_name:String,rsvp_name_3:String,
        video_url:String,invitation_count:String,
        host_2_parent:String,
        din_time:String,
        rsvp_number_3:String,
        host_2:String,
        sender_id:String,
        event_name:String,
        id:String,
        rsvp_name_1:String,
        new_video_url:String,
        event_date:String,
        invitation_limit:String,
        image_url:String,
        rsvp_number_1:String,
        rsvp_number_2:String,
        rsvp_name_4:String,
        sender_name:String,
        rsvp_number_4:String,
        event_cat_id:String,
        gender:String,
        date:String,
        rsvp_name_2:String,
        host_1_parent:String,
        location:String,
        arr_time:String,
        time_label:String,
        invitation_side :String) {
        
        self.invitation_type = invitation_type
        self.host_1 = host_1
        self.venue_name = venue_name
        self.rsvp_name_3 = rsvp_name_3
        self.video_url = video_url
        self.invitation_count = invitation_count
        self.host_2_parent = host_2_parent
        self.din_time = din_time
        self.rsvp_number_3 = rsvp_number_3
        self.host_2 = host_2
        self.sender_id = sender_id
        self.event_name = event_name
        self.id = id
        self.rsvp_name_1 = rsvp_name_1
        self.new_video_url = new_video_url
        self.event_date = event_date
        self.invitation_limit = invitation_limit
        self.image_url = image_url
        self.rsvp_number_1 = rsvp_number_1
        self.rsvp_number_2 = rsvp_number_2
        self.rsvp_name_4 = rsvp_name_4
        self.sender_name = sender_name
        self.rsvp_number_4 = rsvp_number_4
        self.event_cat_id = event_cat_id
        self.gender = gender
        self.date = date
        self.rsvp_name_2 = rsvp_name_2
        self.host_1_parent = host_1_parent
        self.location = location
        self.arr_time = arr_time
        self.time_label = time_label
        self.invitation_side  = invitation_side
    }
}
