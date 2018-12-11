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
    // MARK: GRADIENT
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
    
    // MARK: MESSAGE
    func actionSheetAsAlert(message: String)
    {
        let attributedStringTitle = NSAttributedString(string: Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as! String, attributes: [
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16),
            NSAttributedString.Key.foregroundColor : UIColor.black
            ])
        
        let attributedStringMessage = NSAttributedString(string: message, attributes: [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15),
            NSAttributedString.Key.foregroundColor : UIColor.black
            ])
        
        let actionSheet = UIAlertController(title: "", message: "",  preferredStyle: .actionSheet)
        
        actionSheet.setValue(attributedStringTitle, forKey: "attributedTitle")
        actionSheet.setValue(attributedStringMessage, forKey: "attributedMessage")
        
        let actionButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        actionSheet.addAction(actionButton)
        
        self.present(actionSheet, animated: true, completion: nil)
    }
}

