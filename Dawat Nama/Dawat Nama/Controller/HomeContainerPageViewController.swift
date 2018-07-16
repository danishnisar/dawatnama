//
//  HomeContainerPageViewController.swift
//  Dawat Nama
//
//  Created by MacBook Prp on 14/07/2018.
//  Copyright © 2018 Codiansoft. All rights reserved.
//

import UIKit

class HomeContainerPageViewController: UIPageViewController,UIPageViewControllerDelegate,UIPageViewControllerDataSource,UIScrollViewDelegate {
    
    var mvcMain = MainViewController()
    
    var baseIndex:Int = 0

     lazy var storyB:[UIViewController] = {
        return [
            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PageHome_ViewController") as! PageHome_ViewController,
            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PageAlert_ViewController") as! PageAlert_ViewController,
            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PageProfile_ViewController") as! PageProfile_ViewController
        ]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.dataSource = self
        
        funccall_i()
        regNot()
        
        
    }
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//    }
    
        func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return storyB.count
    }
    
    
    
    
   func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
    
   
    
        let index = storyB.index(of: viewController) ?? 0
  
        if index <= 0 {
            baseIndex = index+1
            return nil
        }
    
        baseIndex = index-1
        return storyB[index-1]
        
        
    }
    
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let index  = storyB.index(of: viewController) ?? 0
        //print(index)
        
        if index >= storyB.count-1 {
            baseIndex = index-1
            return nil
        }
        //viewController.index
        baseIndex = index+1
        return storyB[index+1]
    }
    
    
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        //mvcMain.baselineToggle(indexPath: baseIndex)
        NotificationCenter.default.post(name: NSNotification.Name("\(baseIndex)"), object: nil)
        print(baseIndex)
        
        
    }
    
    
    
    func regNot(){
        NotificationCenter.default.addObserver(self, selector: #selector(funccall_i), name: NSNotification.Name("\(0.0)"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(funccall_ii), name: NSNotification.Name("\(1.0)"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(funccall_iii), name: NSNotification.Name("\(2.0)"), object: nil)
    }
    
    @objc func funccall_i(){
        
        setViewControllers([storyB[0]], direction: .forward, animated: true, completion: nil)
    }
    @objc func funccall_ii(){
        
       setViewControllers([storyB[1]], direction: .forward, animated: true, completion: nil)
    }
    @objc func funccall_iii(){
        
       setViewControllers([storyB[2]], direction: .forward, animated: true, completion: nil)
    }
    
  
    


    
  
    
  

}
