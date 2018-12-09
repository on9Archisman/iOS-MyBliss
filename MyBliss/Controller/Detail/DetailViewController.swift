//
//  DetailViewController.swift
//  MyBliss
//
//  Created by Archisman Banerjee on 10/12/18.
//  Copyright © 2018 Archisman Banerjee. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController
{
    @IBOutlet weak var viewImageOuter: UIView!
    @IBOutlet weak var imageViewLogo: UIImageView!
    @IBOutlet weak var labelHeading: UILabel!
    
    var gradientLayer = CAGradientLayer()
    
    var swipeGesture = UISwipeGestureRecognizer()
    
    var dictFetchResult = NSDictionary()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.clear
        
        addShadowToHeaderContent()
        
        if let title = dictFetchResult["title"] as? String
        {
            labelHeading.text = title
        }
        else
        {
            labelHeading.text = "TBA"
        }
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        // Gesture as POP
        swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(actionSwipeGesture(sender:)))
        swipeGesture.direction = .right
        view.addGestureRecognizer(swipeGesture)
    }
    
    override func viewDidDisappear(_ animated: Bool)
    {
        super.viewDidDisappear(animated)
        
        view.removeGestureRecognizer(swipeGesture)
    }
    
    override func viewWillLayoutSubviews()
    {
        super.viewWillLayoutSubviews()
        
        gradientLayer.frame = view.layer.bounds
        
        self.setGradientLayer(gradientLayer: gradientLayer, firstColor: "FF9D2D" as AnyObject, secondColor: UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 1))
    }
    
    @objc func actionSwipeGesture(sender: UISwipeGestureRecognizer)
    {
        self.navigationController?.pop()
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
