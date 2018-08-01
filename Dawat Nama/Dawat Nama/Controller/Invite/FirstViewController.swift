//
//  FirstViewController.swift
//  Dawat Nama
//
//  Created by MacBook Prp on 31/07/2018.
//  Copyright © 2018 Codiansoft. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var eventCategory: UITextField!
    
    let category = ["", "Mr.", "Ms.", "Mrs."]
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.showsSelectionIndicator = true
        
        
        eventCategory.inputView = pickerView
        addToolbar()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        eventCategory.inputAccessoryView = toolbarNew
        
    }
    @objc func buttonDone(){
        print("done Work")
        eventCategory.resignFirstResponder()
        
    }
    @objc func buttonCancel(){
        print("cancel Work")
        eventCategory.resignFirstResponder()
    }

    

}

extension FirstViewController:UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return category.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return category[row]
    }
    
    // When user selects an option, this function will set the text of the text field to reflect
    // the selected option.
     func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        eventCategory.text = category[row]
    }
    
    
    
    

    
    
    
}
