//
//  HomeDetailVC.swift
//  Dawat Nama
//
//  Created by MacBook Prp on 07/09/2018.
//  Copyright © 2018 Codiansoft. All rights reserved.
//

import UIKit
import WebKit
import SafariServices
class HomeDetailVC: UIViewController,WKUIDelegate,SFSafariViewControllerDelegate {

    @IBOutlet weak var view1Image: UIImageView!
    
    @IBOutlet weak var view2image: UIImageView!
    
    @IBOutlet weak var view3image: UIImageView!
    
    var recivedData = [FetchInviation]()
    
    
    //    MARK: - All Labels
    
    @IBOutlet weak var mainviewHeightscrolling: NSLayoutConstraint!
    @IBOutlet weak var ViewContainerVideoHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var cermonyTitle: UILabel!
    @IBOutlet weak var host1: UILabel!
    @IBOutlet weak var host1parent: UILabel!
    @IBOutlet weak var host2: UILabel!
    @IBOutlet weak var host2parent: UILabel!
    @IBOutlet weak var withfamily: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var datefront: UILabel!
    @IBOutlet weak var nikkah: UILabel!
    @IBOutlet weak var nikkahfront: UILabel!
    @IBOutlet weak var arrival: UILabel!
    @IBOutlet weak var arrivalfront: UILabel!
    @IBOutlet weak var dinner: UILabel!
    @IBOutlet weak var dinnerfront: UILabel!
    @IBOutlet weak var venue: UILabel!
    @IBOutlet weak var resvptitle: UILabel!
    @IBOutlet weak var rsvp1: UILabel!
    @IBOutlet weak var rsvp1front: UILabel!
    @IBOutlet weak var rsvp2: UILabel!
    @IBOutlet weak var rsvp2front: UILabel!
    @IBOutlet weak var rsvp3: UILabel!
    @IBOutlet weak var rsvp3front: UILabel!
    @IBOutlet weak var rsvp4: UILabel!
    @IBOutlet weak var rsvp4front: UILabel!
    @IBOutlet weak var rsvpbottom: UILabel!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        updateUI()

       
    }
    
    @IBAction func closeViewAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func locationAction(_ sender: UIButton) {
    
        
        //openmaporsafari
        print("Location:",recivedData[0].location)
        var halfUrl = ""
        let splitinstance = recivedData[0].location.split(separator: " ")
        for sp in 0..<splitinstance.count{
            halfUrl += "-"
            halfUrl += splitinstance[sp]
        }
        print("HalfUrl",halfUrl)
        let safarVC = SFSafariViewController(url: URL(string: "https://www.google.com/maps/search/\(halfUrl)/")!, entersReaderIfAvailable: true)
        
        present(safarVC, animated: true, completion: nil)
        safarVC.delegate = self
        
        
    }
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    private func updateUI(){
        
        rsvpbottom.isHidden = true
        print(recivedData[0].event_cat_id)
        if recivedData[0].event_cat_id == "1" {
            print("barat",recivedData[0].event_name)
            print("nikkah",recivedData[0].nikkah_time)
            view1Image.image = UIImage(named: "name_card")
            view2image.image = UIImage(named: "baratinvite")
            view3image.image = UIImage(named: "baratinvite")
            cermonyTitle.text = "You are invited whole heartedly on the marriage ceremony"
            host1.text = recivedData[0].host_1
            host1parent.text = "Son of \(recivedData[0].host_1_parent) WEDS"
            host2.text = recivedData[0].host_2
            host2parent.text = "Daughter Of \(recivedData[0].host_2_parent)"
            
            withfamily.text = recivedData[0].invitation_type
            date.text = "Date"
            datefront.text = recivedData[0].date
            
            nikkah.text = "Nikkah"
            nikkahfront.text = recivedData[0].nikkah_time
            arrival.text = "Arrival"
            arrivalfront.text = recivedData[0].arr_time
            dinner.text = recivedData[0].time_label
            dinnerfront.text = recivedData[0].din_time
            venue.text = recivedData[0].venue_name
            
            resvptitle.text = "R.S.V.P"
            rsvp1.text = recivedData[0].rsvp_name_1
            rsvp1front.text = recivedData[0].rsvp_number_1
            rsvp1.textAlignment = .center
            rsvp1front.textAlignment = .center
            
            rsvp2.text = recivedData[0].rsvp_name_2
            rsvp2front.text = recivedData[0].rsvp_number_2
            rsvp2.textAlignment = .center
            rsvp2front.textAlignment = .center
            rsvp3.text = recivedData[0].rsvp_name_3
            rsvp3front.text = recivedData[0].rsvp_number_3
            rsvp3.textAlignment = .center
            rsvp3front.textAlignment = .center
            rsvp4.text = recivedData[0].rsvp_name_4
            rsvp4front.text = recivedData[0].rsvp_number_4
            rsvp4.textAlignment = .center
            rsvp4front.textAlignment = .center
            
        
            
            
        }else if recivedData[0].event_cat_id == "2" {
            print("event name1 ",recivedData[0].event_name)
            
            //valima
            view1Image.image = UIImage(named: "name_card")
            view2image.image = UIImage(named: "walimainvite")
            view3image.image = UIImage(named: "walimainvite")
            cermonyTitle.text = "You are invited whole heartedly on the marriage ceremony"
            
            host1.text = recivedData[0].host_1
            host1parent.text = "Son of \(recivedData[0].host_1_parent) WEDS"
            host1parent.isHidden = false
            
            host2.isHidden = false
            host2parent.isHidden = false
            host2.text = recivedData[0].host_2
            host2parent.text = "Daughter Of \(recivedData[0].host_2_parent)"
            
            withfamily.text = recivedData[0].invitation_type
            date.textAlignment = .center
            datefront.textAlignment = .center
            date.text = "Date"
            datefront.text = recivedData[0].date

            nikkah.textAlignment = .center
            nikkahfront.textAlignment = .center
            nikkah.text = "Arrival"
            nikkahfront.text = recivedData[0].arr_time
            
            arrival.textAlignment = .center
            arrivalfront.textAlignment = .center
            arrival.text = recivedData[0].time_label
            arrivalfront.text = recivedData[0].din_time

            dinner.isHidden = true
            dinnerfront.isHidden = true
            dinner.text = recivedData[0].time_label
            dinnerfront.text = recivedData[0].din_time

            venue.text = recivedData[0].venue_name
            
            resvptitle.text = "R.S.V.P"
            rsvp1.text = recivedData[0].rsvp_name_1
            rsvp1front.text = recivedData[0].rsvp_number_1
            rsvp1.textAlignment = .center
            rsvp1front.textAlignment = .center
            
            rsvp2.text = recivedData[0].rsvp_name_2
            rsvp2front.text = recivedData[0].rsvp_number_2
            rsvp2.textAlignment = .center
            rsvp2front.textAlignment = .center
            rsvp3.text = recivedData[0].rsvp_name_3
            rsvp3front.text = recivedData[0].rsvp_number_3
            rsvp3.textAlignment = .center
            rsvp3front.textAlignment = .center
            rsvp4.text = recivedData[0].rsvp_name_4
            rsvp4front.text = recivedData[0].rsvp_number_4
            rsvp4.textAlignment = .center
            rsvp4front.textAlignment = .center
            
        }else if recivedData[0].event_cat_id == "3" {
            print("event name1 ",recivedData[0].event_name)
            //mehandiinvite
            view1Image.image = UIImage(named: "name_card")
            view2image.image = UIImage(named: "mehandiinvite")
            view3image.image = UIImage(named: "mehandiinvite")
            cermonyTitle.text = "You are invited whole heartedly on the marriage ceremony"
            
            host1.text = recivedData[0].host_1
            host1parent.text = "Son of \(recivedData[0].host_1_parent) WEDS"
            host1parent.isHidden = false
            
            host2.isHidden = false
            host2parent.isHidden = false
            host2.text = recivedData[0].host_2
            host2parent.text = "Daughter Of \(recivedData[0].host_2_parent)"
            
            withfamily.text = "Rasm e Hina"
            date.textAlignment = .center
            datefront.textAlignment = .center
            date.text = "Date"
            datefront.text = recivedData[0].date
            
            nikkah.textAlignment = .center
            nikkahfront.textAlignment = .center
            nikkah.text = "Arrival"
            nikkahfront.text = recivedData[0].arr_time
            
            arrival.textAlignment = .center
            arrivalfront.textAlignment = .center
            arrival.text = recivedData[0].time_label
            arrivalfront.text = recivedData[0].din_time
            
            dinner.isHidden = true
            dinnerfront.isHidden = true
            dinner.text = recivedData[0].time_label
            dinnerfront.text = recivedData[0].din_time
            
            venue.text = recivedData[0].venue_name
            
            resvptitle.text = "R.S.V.P"
            rsvp1.text = recivedData[0].rsvp_name_1
            rsvp1front.text = recivedData[0].rsvp_number_1
            rsvp1.textAlignment = .center
            rsvp1front.textAlignment = .center
            
            rsvp2.text = recivedData[0].rsvp_name_2
            rsvp2front.text = recivedData[0].rsvp_number_2
            rsvp2.textAlignment = .center
            rsvp2front.textAlignment = .center
            rsvp3.text = recivedData[0].rsvp_name_3
            rsvp3front.text = recivedData[0].rsvp_number_3
            rsvp3.textAlignment = .center
            rsvp3front.textAlignment = .center
            rsvp4.text = recivedData[0].rsvp_name_4
            rsvp4front.text = recivedData[0].rsvp_number_4
            rsvp4.textAlignment = .center
            rsvp4front.textAlignment = .center
            
            
        }else{
            print("event name1 ",recivedData[0].event_name)
            
            view1Image.image = UIImage(named: "bdinvite")
            view2image.image = UIImage(named: "bdinvite")
            view3image.image = UIImage(named: "bdinvite")
            cermonyTitle.text = "Birthday \(recivedData[0].gender)"
            
            host1.text = recivedData[0].host_1
            host1parent.isHidden = true
//            host1parent.text = "Son of \(recivedData[0].host_1_parent) WEDS"
            host2.isHidden = true
//            host2.text = recivedData[0].host_2
            host2parent.isHidden = true
//            host2parent.text = "Daughter Of \(recivedData[0].host_2_parent)"
            withfamily.isHidden = true
            withfamily.text = recivedData[0].invitation_type
            date.text = "Date"
            date.textAlignment = .right
            datefront.text = "\(recivedData[0].date)   "
            datefront.textAlignment = .right
            nikkah.text = "Arrival"
            nikkah.textAlignment = .right
            nikkahfront.text = "\(recivedData[0].arr_time)   "
            nikkahfront.textAlignment = .right
            arrival.text = "Cake Cutting"
            arrival.textAlignment = .right
            arrivalfront.text = "\(recivedData[0].din_time)   "
            arrivalfront.textAlignment = .right
            dinner.isHidden = true
            dinner.text = recivedData[0].time_label
            dinnerfront.isHidden = true
            dinnerfront.text = recivedData[0].din_time
            venue.text = recivedData[0].venue_name
            
            resvptitle.text = "R.S.V.P"
            rsvp1.text = recivedData[0].rsvp_name_1
            rsvp1front.text = "\(recivedData[0].rsvp_number_1)   "
            rsvp1.textAlignment = .right
            rsvp1front.textAlignment = .right
            
            rsvp2.text = recivedData[0].rsvp_name_2
            rsvp2front.text = "\(recivedData[0].rsvp_number_2)   "
            rsvp2.textAlignment = .right
            rsvp2front.textAlignment = .right
            rsvp3.text = recivedData[0].rsvp_name_3
            rsvp3front.text = "\(recivedData[0].rsvp_number_3)   "
            rsvp3.textAlignment = .right
            rsvp3front.textAlignment = .right
            
            rsvp4.text = recivedData[0].rsvp_name_4
            rsvp4front.text = "\(recivedData[0].rsvp_number_4)   "
            rsvp4.textAlignment = .right
            rsvp4front.textAlignment = .right
        }
        
        notificationRegister()
        
    }
    
    private func notificationRegister(){
        var videolink = ""
        if recivedData[0].video_url != "0" {
            videolink = recivedData[0].video_url
            UIView.animate(withDuration: 0.8) {
                self.ViewContainerVideoHeightConstraint.constant = 195
                self.mainviewHeightscrolling.constant = 874
            }
        }else if recivedData[0].new_video_url != "no_video"{
            videolink = recivedData[0].new_video_url
            UIView.animate(withDuration: 0.8) {
                self.ViewContainerVideoHeightConstraint.constant = 195
                self.mainviewHeightscrolling.constant = 874
            }
        }else{
            UIView.animate(withDuration: 0.8) {
                self.ViewContainerVideoHeightConstraint.constant = 0
                self.mainviewHeightscrolling.constant -= 195
            }
            return
        }
        
        NotificationCenter.default.post(name: NSNotification.Name("getvideoURL"), object: nil, userInfo: ["video":videolink])
        print("reciveddata",recivedData[0].event_cat_id,recivedData[0].event_name)
    }
    
    
}
