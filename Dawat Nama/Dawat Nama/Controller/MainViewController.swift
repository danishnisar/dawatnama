//
//  ViewController.swift
//  Dawat Nama
//
//  Created by MacBook Prp on 12/07/2018.
//  Copyright © 2018 Codiansoft. All rights reserved.
//

import UIKit

class MainViewController: UIViewController{
   
    @IBOutlet weak var menuContainerConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var mainContainerConstraint: UIView!
    
    var menuConstraintToggle = false ;

    //    lazy var storyB:[UIViewController] = {
//        return [
//            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PageHome_ViewController") as! PageHome_ViewController,
//            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PageAlert_ViewController") as! PageAlert_ViewController,
//            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PageProfile_ViewController") as! PageProfile_ViewController
//        ]
//    }()

    // Mark :- IBOUTLETs Home View
    
    @IBOutlet weak var Menucollection: UICollectionView!
    
    
    //Mark :- Var let Vairables
    
//    let menu:[String] = {
//        return ["Screen-slicing_04","Screen-slicing_07","Screen-slicing_09"]
//    }()
//    var bottomLine:[UIView] = [UIView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
//        Menucollection.delegate = self
//        Menucollection.dataSource = self
//
        

        // Do any additional setup after loading the view, typically from a nib.
//        regMenucellview()
//        regNot()
        
        
    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        authenticate()
             }
    
    
    // MARK :- MenuContainer Function
    @IBAction func menuContainerSction(_ sender: Any) {
        
        if menuConstraintToggle {
            UIView.animate(withDuration: 0.5) {
                                   self.menuContainerConstraint.constant = 186
                self.mainContainerConstraint.backgroundColor = UIColor.clear
                self.mainContainerConstraint.alpha = 1
                self.mainContainerConstraint.isOpaque = false
                
            }
            menuConstraintToggle = false
        }
        else {
            
            UIView.animate(withDuration: 0.5) {
                 self.menuContainerConstraint.constant = 0
                
                self.mainContainerConstraint.backgroundColor = UIColor.black
                self.mainContainerConstraint.alpha = 0.1
                self.mainContainerConstraint.isOpaque = true
                
                
            }

            menuConstraintToggle = true
        }
        
    }

//    func regNot(){
//        NotificationCenter.default.addObserver(self, selector: #selector(funccall_i), name: NSNotification.Name("\(0)"), object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(funccall_ii), name: NSNotification.Name("\(1)"), object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(funccall_iii), name: NSNotification.Name("\(2)"), object: nil)
//    }
    
//    @objc func funccall_i(){
//        
//        baselineToggle(indexPath: 0)
//    }
//    @objc func funccall_ii(){
//        
//        baselineToggle(indexPath: 1)
//    }
//    @objc func funccall_iii(){
//        
//        baselineToggle(indexPath: 2)
//    }
    
    
    func  regMenucellview(){
       
        print("register cell")
        Menucollection.register(UINib(nibName: "HomeMenuCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "menucellview")
        
        
        Menucollection.layer.shadowRadius = 5
        Menucollection.layer.shadowOpacity = 0.2
        Menucollection.layer.shadowOffset = CGSize(width: 1, height: 5)
        Menucollection.clipsToBounds = false

    }
    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        print("3")
//        return 3
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "menucellview", for: indexPath) as! HomeMenuCollectionViewCell
//
//        cell.menuicon.image = UIImage(named: menu[indexPath.item])
//        bottomLine.append(cell.bottom)
//        //print("cell index path\(indexPath.item)")
//        cell.bottom.isHidden = (indexPath.item == 0) ? false : true
//
//
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        print("size\(Menucollection.bounds.width)")
//        return CGSize(width: Menucollection.bounds.width/3 , height: Menucollection.bounds.height)
//
//
//
//    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print("Float:\(Float(indexPath.item))")
//
//        NotificationCenter.default.post(name: NSNotification.Name("\(Float(indexPath.item))"), object: nil)
//        baselineToggle(indexPath:indexPath.item)
//
//    }
//
//    func baselineToggle(indexPath:Int){
//        
//        for ind in 0...2 {
//            if ind == indexPath {
//                print(ind)
//                UIView.animate(withDuration: 0.1) {
//                     self.bottomLine[ind].isHidden = false
//                    
//                }
//
//            }else{
//                UIView.animate(withDuration: 0.1) {
//                    self.bottomLine[ind].isHidden = true
//                }
//               
//            }
//
//        }
        
       

//    }
        //bottomLine[indexPath.item].isHidden = false
        //Menucollection.layoutIfNeeded()

    
    
    // MARK :- Added Invite Function
    @IBAction func inviteButton(_ sender: Any) {
        
        print("invite");
        
    }
    
    //MARK: - Authentication Login/Signup
    
    func authenticate(){
        
        
        
        
        print("auth")
        let userAuth = UserDefaults.standard
        if userAuth.bool(forKey: "token") {
            print("This is inside bool",true)
            let auth = userAuth.value(forKey: "LoggedIN") as! Dictionary<String,String>
            print("Auth Status ",auth["Status"]!)
            print(auth)
            if auth["Status"] ==  "success" {
                
                print("status access")
                //userAuth.removeObject(forKey: "LoggedIN")
            }
        }
        else{
            performSegue(withIdentifier: "authvc", sender: self)
            print(false)
        }
       
        

        
    }
    
   
    
}



