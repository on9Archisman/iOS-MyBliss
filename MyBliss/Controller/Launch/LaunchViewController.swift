//
//  LaunchViewController.swift
//  MyBliss
//
//  Created by Archisman Banerjee on 08/12/18.
//  Copyright © 2018 Archisman Banerjee. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController
{
    @IBOutlet weak var imageViewLogo: UIImageView!
    @IBOutlet weak var labelLaunchTitle: UILabel!
    
    var centerPoint: CGPoint?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        print("Launch Call")
        
        imageViewLogo.frame.size = CGSize(width: 250, height: 250)
        
        labelLaunchTitle.isHidden = true
        labelLaunchTitle.alpha = 0
    }
    
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        
        imageViewLogo.center = view.center
        
        centerPoint = imageViewLogo.center
        
        UIView.animate(withDuration: 1.0, animations: {
            
            self.imageViewLogo.frame.size = CGSize(width: 150, height: 150)
            self.imageViewLogo.center = self.centerPoint!
            
        }) { (flag) in
            
            print("Above Block Status =",flag)
            
            UIView.animate(withDuration: 1.0, delay: 0.25, options: [.curveEaseInOut], animations: {
                
                self.labelLaunchTitle.isHidden = false
                self.labelLaunchTitle.alpha = 1
                
                self.perform(#selector(self.moveToListVC), with: nil, afterDelay: 2.0)
            })
        }
    }
    
    @objc func moveToListVC()
    {
        let listVC = self.storyboard?.instantiateViewController(withIdentifier: "ListViewController") as! ListViewController
        self.navigationController?.push(VC: listVC)
    }
}
