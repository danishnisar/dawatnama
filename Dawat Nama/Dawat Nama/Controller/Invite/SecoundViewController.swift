//
//  SecoundViewController.swift
//  Dawat Nama
//
//  Created by MacBook Prp on 01/08/2018.
//  Copyright © 2018 Codiansoft. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import GooglePlacePicker
import SwiftSpinner

class SecoundViewController: UIViewController {

    var dataCollect:Dictionary = [String: String]()
    var inviteside = true
    var sendreID = ""
    var resvpData = [String]()
    var category = [String]()
    var wed = ["Lunch","Dinner"]
    var birthday = ["Cake Cutting"]
    var addSubmit:UIAlertAction!
    var dataprevioisWhole = [String]()
   
    
    
    @IBOutlet weak var field1: UIView!
    @IBOutlet weak var field2: UIView!
    @IBOutlet weak var field3: UIView!
    @IBOutlet weak var field4: UIView!
    @IBOutlet weak var field5: UIView!
    @IBOutlet weak var field6: UIView!
    @IBOutlet weak var field7: UIView!
    @IBOutlet weak var field8: UIView!
    @IBOutlet weak var field9: UIView!
    @IBOutlet weak var field10: UIView!
    @IBOutlet weak var field11: UIView!
    @IBOutlet weak var field12: UIView!
    @IBOutlet weak var field13: UIView!
    
    @IBOutlet weak var field1HeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var field2HeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var segmentHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var field3HeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var field4HeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var field5HeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var field6HeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var field7HeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var field8HeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var field9HeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var field10HeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var field11HeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var field12HeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var field13HeightConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var invitationTitle: UILabel!
    @IBOutlet weak var invitationInput: UITextField!
    
    @IBOutlet weak var GroomTitle: UILabel!
    @IBOutlet weak var GroomInput: UITextField!
    @IBOutlet weak var segmenControll: UISegmentedControl!
    @IBOutlet weak var GrooSonTitle: UILabel!
    @IBOutlet weak var GroomSonInput: UITextField!
    
    @IBOutlet weak var WedTitle: UILabel!
    @IBOutlet weak var WedShufflebutton: UIButton!
    
    @IBOutlet weak var BrideTitle: UILabel!
    @IBOutlet weak var BrideInput: UITextField!
    @IBOutlet weak var BrideDaughterTitle: UILabel!
    @IBOutlet weak var BrideDaughterInput: UITextField!
    
    @IBOutlet weak var VenuTitle: UILabel!
    @IBOutlet weak var VenuInput: UITextField!
    @IBOutlet weak var locationInput: UITextField!
    @IBOutlet weak var locationImage: UIImageView!
    @IBOutlet weak var DateInput: UITextField!
    @IBOutlet weak var DateImage: UIImageView!
    @IBOutlet weak var NikkahTimeInput: UITextField!
    @IBOutlet weak var NikkahTimeImage: UIImageView!
    @IBOutlet weak var ArrivalTimeInput: UITextField!
    @IBOutlet weak var ArrivalTimeImage: UIImageView!
    @IBOutlet weak var LunchOrDinnerInput: UITextField!
    @IBOutlet weak var LuncOrDinnerTimeInput: UITextField!
    @IBOutlet weak var LunchOrDinnerImage: UIImageView!
    
  
    @IBOutlet weak var birthdayDropInput: UITextField!
    @IBOutlet weak var birthdaytimeInput: UITextField!
    @IBOutlet weak var birthdayTimeclockimage: UIImageView!
    
    
    
    
    let pickerView1 = UIPickerView()
    let pickerView2 = UIPickerView()
    let pickerView3 = UIPickerView()
    let pickerview4 = UIDatePicker()
    let pickerview5 = UIDatePicker()
    let pickerview6 = UIDatePicker()
    let pickerview7 = UIDatePicker()
    let pickerview8 = UIDatePicker()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(dataCollect)
        // Do any additional setup after loading the view.
        
        
        pickerView1.delegate = self
        pickerView1.dataSource = self
        pickerView1.showsSelectionIndicator = true
        
        pickerView2.delegate = self
        pickerView2.dataSource = self
        pickerView2.showsSelectionIndicator = true
        
        pickerView3.delegate = self
        pickerView3.dataSource = self
        pickerView3.showsSelectionIndicator = true
        invitationInput.inputView = pickerView1
        LunchOrDinnerInput.inputView = pickerView2
        birthdayDropInput.inputView = pickerView3
        
        //Location delegate set
        locationInput.delegate = self
        
        
       
        
        
        
        addToolbar()
        NetworkFire()
        birthdayShowupof(cond: true, status: "Barat")
        imageClickable()
        datePicker()
        timepicker()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //imageClickable()
    }

    @IBAction func changesideinvite(_ sender: Any) {
        if inviteside {
            inviteside = false
            GroomTitle.text = "Groom"
            GrooSonTitle.text = "Son Of"
            
            BrideTitle.text = "Bride"
            BrideDaughterTitle.text = "Daughter Of"
            
        }else{
            inviteside = true
            BrideTitle.text = "Groom"
            BrideDaughterTitle.text = "Son Of"
            
            GroomTitle.text = "Bride"
            GrooSonTitle.text = "Daughter Of"

        }
    }
    @IBAction func stepThree(_ sender: Any) {
        
        let userDefault = UserDefaults.standard
        let fetch  = userDefault.value(forKey: "LoggedIN") as! Dictionary<String,String>
        sendreID = fetch["ID"]!
        
        if invitationInput.text == "Barat" {
            
            
            if invitationInput.text == "" || GroomInput.text == "" || GroomSonInput.text == "" || BrideInput.text == "" || BrideDaughterInput.text == "" || VenuInput.text == "" || locationInput.text == "" || DateInput.text == "" || NikkahTimeInput.text == "" || ArrivalTimeInput.text == "" || LuncOrDinnerTimeInput.text == "" {
                print("Some Fields are empty please fill that")
                
                return
                
            }else {
                dataCollect["invitationInput"] = "1"
                dataCollect["sendreID"] = sendreID
                let side = inviteside ? "groom" : "bride"
                dataCollect["side"] = side
                dataCollect["GroomInput.text!"] = GroomInput.text!
                let segmentSelect = (segmenControll.selectedSegmentIndex == 0) ?  "Boy":"Girl"
                //dataprevioisWhole.append(segmentSelect)
                dataCollect["segmentSelect"] = segmentSelect
                dataCollect["GroomSonInput.text!"] = GroomSonInput.text!
                dataCollect["BrideInput.text!"] = BrideInput.text!
                dataCollect["BrideDaughterInput.text!"] = BrideDaughterInput.text!
                dataCollect["VenuInput.text!"] = VenuInput.text!
                dataCollect["locationInput.text!"] = locationInput.text!
                dataCollect["DateInput.text!"] = DateInput.text!
                dataCollect["ArrivalTimeInput.text!"] = ArrivalTimeInput.text!
                dataCollect["NikkahTimeInput.text!"] = NikkahTimeInput.text!
                dataCollect["lunchDineinput"] = LunchOrDinnerInput.text!
                dataCollect["lunchdinnerinputtime!"] = LuncOrDinnerTimeInput.text!
                reservationAction()
                
            }
            
            
            
            
        }else if invitationInput.text == "Walima" || invitationInput.text == "Mehandi"{
            
            if invitationInput.text == "" || GroomInput.text == "" || GroomSonInput.text == "" || BrideInput.text == "" || BrideDaughterInput.text == "" || VenuInput.text == "" || locationInput.text == "" || DateInput.text == "" || ArrivalTimeInput.text == "" || LuncOrDinnerTimeInput.text == "" {
                print("Some Fields are empty please fill that")
                return
                
            }else {
                if invitationInput.text == "Walima"{
                    dataCollect["invitationInput"] = "2"
                }else{
                    dataCollect["invitationInput"] = "3"
                }
                dataCollect["sendreID"] = sendreID
                let side = inviteside ? "groom" : "bride"
                dataCollect["side"] = side
                dataCollect["GroomInput.text!"] = GroomInput.text!
                let segmentSelect = (segmenControll.selectedSegmentIndex == 0) ?  "Boy":"Girl"
                //dataprevioisWhole.append(segmentSelect)
                dataCollect["segmentSelect"] = segmentSelect
                dataCollect["GroomSonInput.text!"] = GroomSonInput.text!
                dataCollect["BrideInput.text!"] = BrideInput.text!
                dataCollect["BrideDaughterInput.text!"] = BrideDaughterInput.text!
                dataCollect["VenuInput.text!"] = VenuInput.text!
                dataCollect["locationInput.text!"] = locationInput.text!
                dataCollect["DateInput.text!"] = DateInput.text!
                dataCollect["ArrivalTimeInput.text!"] = ArrivalTimeInput.text!
                dataCollect["NikkahTimeInput.text!"] = ""
                dataCollect["lunchDineinput"] = LunchOrDinnerInput.text!
                dataCollect["lunchdinnerinputtime!"] = LuncOrDinnerTimeInput.text!
                reservationAction()
                
            }
            
        }else{
            
            if invitationInput.text == "" || GroomInput.text == "" || VenuInput.text == "" || locationInput.text == "" || DateInput.text == "" || ArrivalTimeInput.text == "" || birthdaytimeInput.text == "" {
                print("Some Fields are empty please fill that")
                return
                
            }else {
                
                dataCollect["invitationInput"] = "4"
                dataCollect["sendreID"] = sendreID
                let side = ""
                dataCollect["side"] = side
                dataCollect["GroomInput.text!"] = GroomInput.text!
                let segmentSelect = (segmenControll.selectedSegmentIndex == 0) ?  "Boy":"Girl"
                dataprevioisWhole.append(segmentSelect)
                dataCollect["segmentSelect"] = segmentSelect
                dataCollect["GroomSonInput.text!"] = ""
                dataCollect["BrideInput.text!"] = ""
                dataCollect["BrideDaughterInput.text!"] = ""
                dataCollect["VenuInput.text!"] = VenuInput.text!
                dataCollect["locationInput.text!"] = locationInput.text!
                dataCollect["DateInput.text!"] = DateInput.text!
                dataCollect["ArrivalTimeInput.text!"] = ArrivalTimeInput.text!
                dataCollect["NikkahTimeInput.text!"] = ""
                dataCollect["lunchDineinput"] = ""
                dataCollect["lunchdinnerinputtime!"] = ""
                dataCollect["cakeinput"] = birthdayDropInput.text!
                dataCollect["cakeTime"] = birthdaytimeInput.text
                reservationAction()
                
                
            }
            
            
            
        }
        
        
        
        
    }
    
    //MARK: - Add function reservationAction
    private func reservationAction(){
        
        let alert  = UIAlertController(title: "RSVP", message: "Add Reservation Person", preferredStyle: .alert)
        
        
        for i in 0..<6{
            alert.addTextField { (resvp) in
                resvp.returnKeyType = .next
                
                if 0 == i%2 {
                    print("modules",i)
                    resvp.placeholder = "RSVP Name"
                }else{
                    resvp.placeholder = "RSVP Number"
                    resvp.keyboardType = .numberPad
                    
                }
            
                
                if i < 2 {
                resvp.addTarget(alert, action: #selector(alert.alertBoxField), for: .editingChanged)
                }
                if i == 5 {
                    resvp.returnKeyType = .done
                }
            }
        }
        
//        [
//          "resvp_name_0": "resvp dani",
//          "resvp_number_1": "03172565496",
//          "resvp_name_2": "",
//          "resvp_number_3": "",
//          "resvp_name_4": "",
//         "resvp_number_5": ""]
        
        addSubmit = UIAlertAction(title: "Submit", style: .default) { (submitAction) in
            for i in 0..<6{
                
               // print("Texfield\(i) = \(String(describing: alert.textFields?[i].text))")
                
                if 0 == i%2 {
                    //self.resvpData[i] = alert.textFields?[i].text ?? "nildata"
                    let data = alert.textFields?[i].text ?? "No Data"
                    self.dataCollect["resvp_name_\(i)"] = data


                }else {
                    let data = alert.textFields?[i].text ?? "No Data"
                    self.dataCollect["resvp_number_\(i)"] = data
                }
            }
            self.dataCollect["LunchOrDinnerInput"] = self.LunchOrDinnerInput.text!
            self.dataCollect["LuncOrDinnerTimeInput"] = self.LuncOrDinnerTimeInput.text!
          //  self.dataCollect[] = ""
//            let convertstring = "\(self.numberOfPepoleInvite)"
//            self.dataprevioisWhole.append(convertstring)
            
            
                 self.performSegue(withIdentifier: "upload", sender: self)
           
           
            
        }//
        addSubmit.isEnabled = false
        
        let addCancel = UIAlertAction(title: "Cacnel", style: .destructive) { (cancelAction) in
            print("cancel")
        }
        
        
        alert.addAction(addSubmit)
        alert.addAction(addCancel)
        
        
        
        present(alert, animated: true) {
            print("oncomplete")
        }
        
        
    }
    
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "upload" {
            let vc = segue.destination as! UploadRecordVC
            vc.dataCollect = dataCollect
            
        }
    }
    
    
  
    
        func addToolbar(){
            let toolbarNew = UIToolbar()
            toolbarNew.barStyle = .default
            toolbarNew.isTranslucent = true
            toolbarNew.tintColor = UIColor(red: 93/255, green: 216/255, blue: 255/255, alpha: 1)
            toolbarNew.sizeToFit()
    
            // Adding Button Toolbar
            let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(buttonDone))
            let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(buttonCancel))
            toolbarNew.setItems([cancelButton,spaceButton,doneButton], animated: true)
            toolbarNew.isUserInteractionEnabled = true
            invitationInput.inputAccessoryView = toolbarNew
            birthdayDropInput.inputAccessoryView = toolbarNew
            LunchOrDinnerInput.inputAccessoryView = toolbarNew
            LuncOrDinnerTimeInput.inputAccessoryView = toolbarNew
            DateInput.inputAccessoryView = toolbarNew
            NikkahTimeInput.inputAccessoryView = toolbarNew
            ArrivalTimeInput.inputAccessoryView = toolbarNew
            birthdaytimeInput.inputAccessoryView = toolbarNew
    
        }
    
        @objc func buttonDone(){
            print("done Work")
            invitationInput.resignFirstResponder()
            birthdayDropInput.resignFirstResponder()
            LunchOrDinnerInput.resignFirstResponder()
            DateInput.resignFirstResponder()
            NikkahTimeInput.resignFirstResponder()
            ArrivalTimeInput.resignFirstResponder()
            birthdaytimeInput.resignFirstResponder()
            LuncOrDinnerTimeInput.resignFirstResponder()
        }
        @objc func buttonCancel(){
            print("cancel Work")
            invitationInput.resignFirstResponder()
            birthdayDropInput.resignFirstResponder()
            LunchOrDinnerInput.resignFirstResponder()
            DateInput.resignFirstResponder()
            NikkahTimeInput.resignFirstResponder()
            ArrivalTimeInput.resignFirstResponder()
            birthdaytimeInput.resignFirstResponder()
            LuncOrDinnerTimeInput.resignFirstResponder()
        }
    
    
    //MARK: - imageClickable
    func imageClickable(){
        let Tapgesture1 = UITapGestureRecognizer(target: self, action: #selector(getImageTapId(_:)))
        DateImage.isUserInteractionEnabled = true
        DateImage.tag = 0
        DateImage.addGestureRecognizer(Tapgesture1)
        
        let Tapgesture2 = UITapGestureRecognizer(target: self, action: #selector(getImageTapId(_:)))
        locationImage.isUserInteractionEnabled = true
        locationImage.tag = 1
        locationImage.addGestureRecognizer(Tapgesture2)
        
        let Tapgesture3 = UITapGestureRecognizer(target: self, action: #selector(getImageTapId(_:)))
        NikkahTimeImage.isUserInteractionEnabled = true
        NikkahTimeImage.tag = 2
        NikkahTimeImage.addGestureRecognizer(Tapgesture3)
        
        let Tapgesture4 = UITapGestureRecognizer(target: self, action: #selector(getImageTapId(_:)))
        ArrivalTimeImage.isUserInteractionEnabled = true
        ArrivalTimeImage.tag = 3
        ArrivalTimeImage.addGestureRecognizer(Tapgesture4)
        
        let Tapgesture5 = UITapGestureRecognizer(target: self, action: #selector(getImageTapId(_:)))
        LunchOrDinnerImage.isUserInteractionEnabled = true
        LunchOrDinnerImage.tag = 4
        LunchOrDinnerImage.addGestureRecognizer(Tapgesture5)
        
        let Tapgesture6 = UITapGestureRecognizer(target: self, action: #selector(SecoundViewController.getImageTapId(_:)))
        birthdayTimeclockimage.isUserInteractionEnabled = true
        birthdayTimeclockimage.tag = 5
        birthdayTimeclockimage.addGestureRecognizer(Tapgesture6)
    }
    
    @objc func getImageTapId(_ sender:AnyObject){
        
        print("enterd \(sender.view.tag)")
        switch sender.view.tag {
        case 0:
            print("Date Tapped")
            DateInput.becomeFirstResponder()
            break;
        case 1:
            print("Location Tapped")
            break;
        case 2:
            print("Nikkah Tapped")
            NikkahTimeInput.becomeFirstResponder()
            break;
        case 3:
            print("arrival Tapped")
            ArrivalTimeInput.becomeFirstResponder()
            break;
        case 4:
            print("lunchdinner Tapped")
            LuncOrDinnerTimeInput.becomeFirstResponder()
            break;
        case 5:
            print("Cake Tapped")
            birthdaytimeInput.becomeFirstResponder()
            break;
        default:
            print("not supported")
        }
    }
    
    //MARK: - DatePickerFunction
    private func datePicker(){
        
        DateInput.inputView = pickerview4
        pickerview4.datePickerMode = .date
        pickerview4.addTarget(self, action: #selector(setdateinView(_:)), for: .valueChanged)
        
        
    }
    private func timepicker(){
        NikkahTimeInput.inputView = pickerview5
        ArrivalTimeInput.inputView = pickerview6
        birthdaytimeInput.inputView = pickerview7
        LuncOrDinnerTimeInput.inputView = pickerview8
        
        pickerview5.datePickerMode = .time
        pickerview6.datePickerMode = .time
        pickerview7.datePickerMode = .time
        pickerview8.datePickerMode = .time
        
        pickerview5.addTarget(self, action: #selector(setdateinView(_:)), for: .valueChanged)
        pickerview6.addTarget(self, action: #selector(setdateinView(_:)), for: .valueChanged)
        pickerview7.addTarget(self, action: #selector(setdateinView(_:)), for: .valueChanged)
        pickerview8.addTarget(self, action: #selector(setdateinView(_:)), for: .valueChanged)
    }
   
    
    @objc func setdateinView(_ datepicker:UIDatePicker){
        if datepicker == pickerview4{
            let dateFormater = DateFormatter()
            dateFormater.dateFormat = "dd-MM-YYYY"
            DateInput.text = dateFormater.string(from: datepicker.date)
            print("Picker4 \(DateInput.text)")
        }else if datepicker == pickerview5{
            let dateFormater = DateFormatter()
            dateFormater.dateFormat = "hh:mm a"
            NikkahTimeInput.text = dateFormater.string(from: datepicker.date)
            print("worksetdate")
        }else if datepicker == pickerview6 {
            let dateFormater = DateFormatter()
            dateFormater.dateFormat = "hh:mm a"
            ArrivalTimeInput.text = dateFormater.string(from: datepicker.date)
            print("worksetdate")
        }else if datepicker == pickerview7{
            let dateFormater = DateFormatter()
            dateFormater.dateFormat = "hh:mm a"
            birthdaytimeInput.text = dateFormater.string(from: datepicker.date)
            print("worksetdate")
        }else{
            let dateFormater = DateFormatter()
            dateFormater.dateFormat = "hh:mm a"
            LuncOrDinnerTimeInput.text = dateFormater.string(from: datepicker.date)
            print("worksetdate")
        }
        
    }
    

    
    
    private func NetworkFire(){
        Alamofire.request(RestFull.fetch_Event).responseJSON { (response) in
            if response.result.isSuccess{
                let data = JSON(response.result.value!)
                self.extractJson(data:data)
                print(data)
                
            }else{
                print("Network error\(response.result.error!)")
            }
        }
        
        
    }
    private func extractJson(data:JSON){
        
        let parse = data["result"]["data"].count
        if parse != 0 {
            for i in 0..<parse {
              let eventName = data["result"]["data"][i]["events_name"].stringValue
                category.append(eventName)
            }
            invitationInput.text = category[0]
            birthdayDropInput.text = birthday[0]
            LunchOrDinnerInput.text = wed[0]
        }else{
            print("No Event Find")
        }
        
        
    }
    /*
     
     field1  - invitation 50
     field2 -  groom 50
     segment = segment 28
     field3  = weds button 50
     field4 = son of 50
     field5 = bride 50
     field6 = daughter of 50
     field7 = venue 50
     field8 = location 58
     field9 = date 58
     field10 = Nikkah Time 58
     field11 = Arrival Time 58
     field12 = lunch or dinner 58
     field13 = cake 58
     
     */

    
    private func birthdayShowupof(cond:Bool,status:String){
        if status  == "Birthday" {
            print("Birthday called")
            field1.isHidden = (cond == true) ? false : true
            field1HeightConstraint.constant = 50
            
            segmenControll.isHidden = (cond == true) ? false : true
            segmentHeightConstraint.constant = 28
            
            field2.isHidden = (cond == true) ? false : true
            field2HeightConstraint.constant = 50
            GroomTitle.text = "Name"
            
            field3.isHidden = cond
            field3HeightConstraint.constant = 0
            
            field4.isHidden = cond
            field4HeightConstraint.constant = 0
            
            field5.isHidden = cond
            field5HeightConstraint.constant = 0
            
            field6.isHidden = cond
            field6HeightConstraint.constant = 0
            
            field7.isHidden = (cond == true) ? false : true
            field7HeightConstraint.constant = 50
            
            field8.isHidden = (cond == true) ? false : true
            field8HeightConstraint.constant = 58
            
            field9.isHidden = (cond == true) ? false : true
            field9HeightConstraint.constant = 58
            
            field10.isHidden = cond
            field10HeightConstraint.constant = 0
            
            field11.isHidden = (cond == true) ? false : true
            field11HeightConstraint.constant = 58
            
            field12.isHidden = cond
            field12HeightConstraint.constant = 0
            
            field13.isHidden = (cond == true) ? false : true
            field13HeightConstraint.constant = 58
            
        }else if status == "Barat"{
            
            print("Barat called")
            field1.isHidden = (cond == true) ? false : true
            field1HeightConstraint.constant = 50
            segmenControll.isHidden = cond
            segmentHeightConstraint.constant = 0
            
            field2.isHidden = (cond == true) ? false : true
            field2HeightConstraint.constant = 50
            
            field3.isHidden = (cond == true) ? false : true //not britth
            field3HeightConstraint.constant = 50
            
            field4.isHidden = (cond == true) ? false : true //not britth
            field4HeightConstraint.constant = 50
            
            field5.isHidden = (cond == true) ? false : true //not britth
            field5HeightConstraint.constant = 50
            
            field6.isHidden = (cond == true) ? false : true //not britth
            field6HeightConstraint.constant = 50
            
            field7.isHidden = (cond == true) ? false : true
            field7HeightConstraint.constant = 50
            
            field8.isHidden = (cond == true) ? false : true
            field8HeightConstraint.constant = 58
            
            field9.isHidden = (cond == true) ? false : true
            field9HeightConstraint.constant = 58
            
            field10.isHidden = (cond == true) ? false : true //not britth
            field10HeightConstraint.constant = 58
            
            field11.isHidden = (cond == true) ? false : true
            field11HeightConstraint.constant = 58
            
            field12.isHidden = (cond == true) ? false : true //not britth
            field12HeightConstraint.constant = 58
            
            field13.isHidden = cond
            field13HeightConstraint.constant = 0
            
        }else{
            print("Walima And Mehndi called")
            field1.isHidden = (cond == true) ? false : true
            field1HeightConstraint.constant = 50
            
            segmenControll.isHidden = cond
            segmentHeightConstraint.constant = 0
            
            field2.isHidden = (cond == true) ? false : true
            field2HeightConstraint.constant = 50
            
            field3.isHidden = (cond == true) ? false : true //not britth
            field3HeightConstraint.constant = 50
            
            field4.isHidden = (cond == true) ? false : true //not britth
            field4HeightConstraint.constant = 50
            
            field5.isHidden = (cond == true) ? false : true //not britth
            field5HeightConstraint.constant = 50
            
            field6.isHidden = (cond == true) ? false : true //not britth
            field6HeightConstraint.constant = 50
            
            field7.isHidden = (cond == true) ? false : true
            field7HeightConstraint.constant = 50
            
            field8.isHidden = (cond == true) ? false : true
            field8HeightConstraint.constant = 58
            
            field9.isHidden = (cond == true) ? false : true
            field9HeightConstraint.constant = 58
            
            field10.isHidden = cond
            field10HeightConstraint.constant = 0
            
            field11.isHidden = (cond == true) ? false : true
            field11HeightConstraint.constant = 58
            
            field12.isHidden = (cond == true) ? false : true //not britth
            field12HeightConstraint.constant = 58
            
            field13.isHidden = cond
            field13HeightConstraint.constant = 0
            
        }
        
        self.view.layoutIfNeeded()
        
 
    }
    
   
  
    
    

}

extension SecoundViewController:UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == pickerView1{
            return category.count
        }else if pickerView == pickerView2{
            return wed.count
        }else{
            return birthday.count
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pickerView1 {
            return category[row]

        }else if pickerView == pickerView2{
            return wed[row]
        }else{
            return birthday[row]
        }
    }
    
    // When user selects an option, this function will set the text of the text field to reflect
    // the selected option.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == pickerView1 {
            invitationInput.text = category[row]
            LunchOrDinnerInput.text = wed[0]
            birthdayDropInput.text = birthday[0]
            if category[row] == "Birthday"{
                 birthdayShowupof(cond: true, status: category[row])
                
            }else if category[row] == "Mehndi"{
                
                birthdayShowupof(cond: true, status: category[row])
            }else{
                
                birthdayShowupof(cond: true, status: category[row])
            }
            
        }else if pickerView == pickerView2 {
            LunchOrDinnerInput.text = wed[row]
        }else{
            birthdayDropInput.text = birthday[row]
        }
        
    }
}

extension SecoundViewController:UITextFieldDelegate,GMSPlacePickerViewControllerDelegate {
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("begin editin")
        
        let config = GMSPlacePickerConfig(viewport: nil)
        let placePicker = GMSPlacePickerViewController(config: config)
        placePicker.delegate = self
        
        present(placePicker, animated: true, completion: nil)
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
       
    }
    
    // To receive the results from the place picker 'self' will need to conform to
    // GMSPlacePickerViewControllerDelegate and implement this code.
    func placePicker(_ viewController: GMSPlacePickerViewController, didPick place: GMSPlace) {
        // Dismiss the place picker, as it cannot dismiss itself.
        viewController.dismiss(animated: true, completion: nil)
        
        locationInput.text = "\(place.name) \(place.formattedAddress ?? "notdate")"
        
        print("Place name \(place.name)")
        print("Place address \(String(describing: place.formattedAddress))")
        print("Place attributions \(String(describing: place.attributions))")
    }
    
    func placePickerDidCancel(_ viewController: GMSPlacePickerViewController) {
        // Dismiss the place picker, as it cannot dismiss itself.
        viewController.dismiss(animated: true, completion: nil)
        locationInput.text = ""
        print("No place selected")
    }
    
}

extension UIAlertController {
    
    @objc func alertBoxField(){
        
       
        if let text1 = textFields?[0].text , let text2 = textFields?[1].text{
            actions[0].isEnabled = (text1.count > 3) && (text2.count > 3)
        }
        
    }
}
