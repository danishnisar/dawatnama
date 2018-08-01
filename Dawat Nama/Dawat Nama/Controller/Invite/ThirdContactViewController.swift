//
//  ThirdContactViewController.swift
//  Dawat Nama
//
//  Created by MacBook Prp on 01/08/2018.
//  Copyright © 2018 Codiansoft. All rights reserved.
//

import UIKit
import Contacts

class ThirdContactViewController: UIViewController {

    //MARK: - Variables,Constant and Outlets
    
    @IBOutlet weak var contacttblView: UITableView!
    
    var contactModel = [ContactModel]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //Mark: - Fetch Contact Function
        fetchContatcs()
        
        //Mark: - Contatc Cell Nib Register
        contactCell()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    func contactCell(){
        
        contacttblView.register(UINib(nibName: "ContactTableViewCell", bundle: nil), forCellReuseIdentifier: "contactcell")
        
        
    }
    
    
    //MARK: - Fetch Contacts
    private func fetchContatcs(){
        print("Fetching Contatc Start")
        
        let store = CNContactStore()
        
        store.requestAccess(for: .contacts) { (granted, err) in
            if let err = err {
                print("Error in accesing the contatc",err)
            }
            if granted {
                print("access Granted")
                //MARK: - Fetching Start
                let Keys = [CNContactGivenNameKey,CNContactPhoneNumbersKey,CNContactImageDataKey]
                let request = CNContactFetchRequest(keysToFetch: Keys as [CNKeyDescriptor])
                
                do {
                    try store.enumerateContacts(with: request) { (contact, StopPointerIfYouWantToStopEnum) in
                        
                        
                        if let phoneNumber = contact.phoneNumbers.first?.value.stringValue {
                            
                            print(contact.givenName)
                            print(phoneNumber)
                            print(contact.imageData ?? "N/A")
                            
                            let name = contact.givenName
                            let number = phoneNumber
                            self.contactModel.append(ContactModel(name: name, phone: number, image: "N/A"))
                            
//                            if contact.imageDataAvailable {
//                               var image  = contact.imageData
//                                self.contactModel.append(ContactModel(name: name, phone: number, image: image))
//                            }else{
//
//                                var image = "pinmap"
//                                self.contactModel.append(ContactModel(name: name, phone: number, image: image))
//                            }
                        }
                    }
                }catch let err {
                    print("fatal error",err)
                }
                DispatchQueue.main.async {
                    self.contacttblView.reloadData()
                }
            }else{
                print("access denied")
            }
            
        }
        
        
        
        
    }
    

}


extension ThirdContactViewController:UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactcell", for: indexPath) as! ContactTableViewCell
        
        cell.CNName.text = contactModel[indexPath.row].CNName
        return cell
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    
    
    
}













