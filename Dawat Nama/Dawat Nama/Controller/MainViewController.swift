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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        regMenucellview()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func  regMenucellview(){
        
        Menucollection.register(UINib(nibName: "HomeMenuCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "menucellview")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "menucellview", for: indexPath) as! HomeMenuCollectionViewCell
        
        cell.menuicon.image = UIImage(named: "Screen-slicing_04")
        
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Menucollection.contentSize.width / 3, height: Menucollection.contentSize.height)
    }
    
    


}

