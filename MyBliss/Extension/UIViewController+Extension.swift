//
//  UIViewController+Extension.swift
//  MyBliss
//
//  Created by Archisman Banerjee on 08/12/18.
//  Copyright © 2018 Archisman Banerjee. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController
{
    func setGradientLayer(gradientLayer: CAGradientLayer, firstColor: AnyObject, secondColor: AnyObject)
    {
        // let gradientLayer = CAGradientLayer()
        
        // gradientLayer.frame = self.view.bounds
        
        var colorOne = UIColor()
        var colorTwo = UIColor()
        
        if let one = firstColor as? String
        {
            colorOne = Helper.hexStringToUIColor(HexCode: one)
        }
        else
        {
            colorOne = firstColor as! UIColor
        }
        
        if let two = secondColor as? String
        {
            colorTwo = Helper.hexStringToUIColor(HexCode: two)
        }
        else
        {
            colorTwo = secondColor as! UIColor
        }
        
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        
        gradientLayer.locations = [0.0, 0.7]
        
        // self.view.layer.addSublayer(gradientLayer)
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
}

