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
    @IBOutlet weak var imageBackground: UIImageView!
    @IBOutlet weak var viewImageOuter: UIView!
    @IBOutlet weak var imageViewLogo: UIImageView!
    @IBOutlet weak var labelHeading: UILabel!
    @IBOutlet weak var scrollViewDetail: UIScrollView!
    @IBOutlet weak var scrollViewImageContent: UIImageView!
    @IBOutlet weak var scrollViewLabelContent: UILabel!
    
    var gradientLayer = CAGradientLayer()
    
    var swipeGesture = UISwipeGestureRecognizer()
    
    var dictFetchResult = NSDictionary()
    
    // MARK: ViewController LifeCycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.clear
        
        // Heading Image
        addShadowToHeaderContent()
        
        // Set Content
        if let title = dictFetchResult["title"] as? String
        {
            labelHeading.text = title
        }
        else
        {
            labelHeading.text = "TBA"
        }
        
        if let imageUrl = dictFetchResult["imageUrl"] as? String
        {
            imageBackground.imageFromServerURL(imageUrl, placeHolder: UIImage.init(named: "logoMyBliss"))
            scrollViewImageContent.imageFromServerURL(imageUrl, placeHolder: UIImage.init(named: "logoMyBliss"))
        }
        else
        {
            imageBackground.image = UIImage.init(named: "logoMyBliss")
            scrollViewImageContent.image = UIImage.init(named: "logoMyBliss")
        }
        
        scrollViewImageContent.layer.cornerRadius = 10
        scrollViewImageContent.layer.borderWidth = 0.5
        scrollViewImageContent.layer.borderColor = UIColor.white.cgColor
        scrollViewImageContent.layer.masksToBounds = true
        
        if let description = dictFetchResult["description"] as? String
        {
            scrollViewLabelContent.text = description
        }
        else
        {
            scrollViewLabelContent.text = ""
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
    
    // MARK: Status Bar
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .lightContent
    }
    
    // MARK: Miscellaneous
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
