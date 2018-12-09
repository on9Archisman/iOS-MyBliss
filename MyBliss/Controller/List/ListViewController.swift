//
//  ListViewController.swift
//  MyBliss
//
//  Created by Archisman Banerjee on 08/12/18.
//  Copyright © 2018 Archisman Banerjee. All rights reserved.
//

import UIKit

class ListViewController: UIViewController
{
    @IBOutlet weak var viewImageOuter: UIView!
    @IBOutlet weak var imageViewLogo: UIImageView!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var viewActivity: UIView!
    
    var gradientLayer = CAGradientLayer()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.clear
        
        addShadowToHeaderContent()
        
        // Date
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d, yyyy"
        let result = formatter.string(from: date)
        labelDate.text = result
        
        viewActivity.layer.cornerRadius = 10
        viewActivity.clipsToBounds = true
        view.bringSubviewToFront(viewActivity)
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        viewActivity.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        
        viewActivity.isHidden = false
        
        Helper.callAPIWithDataTask(param: "v1/dummy?page=1", method: "get", data: nil) { (flag, result) in
            
            print("Response Flag =",flag)
            
            DispatchQueue.main.async {
                self.viewActivity.isHidden = true
            }
            
            if (flag)
            {
                sel
            }
            else
            {
                
            }
        }
    }
    
    override func viewWillLayoutSubviews()
    {
        super.viewWillLayoutSubviews()
        
        gradientLayer.frame = view.layer.bounds
        
        self.setGradientLayer(gradientLayer: gradientLayer, firstColor: UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 1), secondColor: "429ED8" as AnyObject)
    }
    
    func addShadowToHeaderContent()
    {
        imageViewLogo.layer.cornerRadius = imageViewLogo.bounds.height / 2
        imageViewLogo.layer.masksToBounds = true
        
        viewImageOuter.backgroundColor = UIColor.clear
        viewImageOuter.layer.shadowColor = UIColor.black.cgColor
        viewImageOuter.layer.shadowOffset = CGSize(width: 3, height: 3)
        viewImageOuter.layer.shadowOpacity = 0.7
        viewImageOuter.layer.shadowRadius = 4.0
        viewImageOuter.layer.shadowPath = UIBezierPath.init(roundedRect: viewImageOuter.bounds, cornerRadius: viewImageOuter.bounds.height/2).cgPath
    }
}
