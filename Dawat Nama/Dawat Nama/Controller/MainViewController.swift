//
//  ViewController.swift
//  Dawat Nama
//
//  Created by MacBook Prp on 12/07/2018.
//  Copyright © 2018 Codiansoft. All rights reserved.
//

import UIKit

class MainViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
   
    
    // Mark :- IBOUTLETs Home View
    
    @IBOutlet weak var Menucollection: UICollectionView!
    
    
    //Mark :- Var let Vairables
    
    let menu:[String] = {
        return ["Screen-slicing_04","Screen-slicing_07","Screen-slicing_09"]
    }()
    var bottomLine:[UIView] = [UIView]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Menucollection.delegate = self
        Menucollection.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
        regMenucellview()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func  regMenucellview(){
       
        print("register cell")
        Menucollection.register(UINib(nibName: "HomeMenuCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "menucellview")
        
        
        Menucollection.layer.shadowRadius = 5
        Menucollection.layer.shadowOpacity = 0.2
        Menucollection.layer.shadowOffset = CGSize(width: 1, height: 5)
        Menucollection.clipsToBounds = false

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("3")
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "menucellview", for: indexPath) as! HomeMenuCollectionViewCell
        
        cell.menuicon.image = UIImage(named: menu[indexPath.item])
        bottomLine.append(cell.bottom)
        cell.bottom.isHidden = (indexPath.item == 0) ? false : true
        
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        print("size\(Menucollection.bounds.width)")
        return CGSize(width: Menucollection.bounds.width/3 , height: Menucollection.bounds.height)
        
        
        
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
        NotificationCenter.default.post(name: NSNotification.Name("\(indexPath.item)"), object: nil)
        
        for ind in 0...indexPath.count {
            if ind == indexPath.item {
                bottomLine[ind].isHidden = false
            }else{
                bottomLine[ind].isHidden = true
            }
        }
    
    }
    
        //bottomLine[indexPath.item].isHidden = false
        //Menucollection.layoutIfNeeded()
    
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        
       // Menucollection.selec
    }
    

    
    


}

