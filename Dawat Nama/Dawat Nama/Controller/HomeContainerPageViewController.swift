//
//  HomeContainerPageViewController.swift
//  Dawat Nama
//
//  Created by MacBook Prp on 14/07/2018.
//  Copyright © 2018 Codiansoft. All rights reserved.
//

import UIKit

class HomeContainerPageViewController: UIPageViewController,UIPageViewControllerDelegate,UIPageViewControllerDataSource {
    
    

    lazy var storyB:[UIViewController] = {
        return [
            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PageHome_ViewController") as! PageHome_ViewController,
            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PageAlert_ViewController") as! PageAlert_ViewController
//            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PageHome_ViewController") as! PageHome_ViewController
        ]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewControllers([storyB[0]], direction: .forward, animated: true, completion: nil)
        
    }
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return storyB.count
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let index = storyB.index(of: viewController) ?? 0
        if index <= 0 {
            return nil
        }
        return storyB[index-1]
        
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let index  = storyB.index(of: viewController) ?? 0
        if index >= storyB.count-1 {
            return nil
        }
        return storyB[index+1]
    }
   
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("HomeContainerPageViewController touch")
    }
    

}
