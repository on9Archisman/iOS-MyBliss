//
//  UINavigationController+Extension.swift
//  MyBliss
//
//  Created by Archisman Banerjee on 08/12/18.
//  Copyright © 2018 Archisman Banerjee. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController
{
    func pop()
    {
        addTransition(transitionType: CATransitionType.fade.rawValue, transitionSubType: nil)
        popViewController(animated: false)
    }
    
    func popToVC(VCArray: [UIViewController], Flag: Int)
    {
        addTransition(transitionType: CATransitionType.fade.rawValue, transitionSubType: nil)
        popToViewController(VCArray[Flag], animated: false)
    }
    
    func popToRoot()
    {
        addTransition(transitionType: CATransitionType.fade.rawValue, transitionSubType: nil)
        popToRootViewController(animated: false)
    }
    
    func push(VC: UIViewController)
    {
        addTransition(transitionType: CATransitionType.fade.rawValue, transitionSubType: nil)
        pushViewController(VC, animated: false)
    }
    
    func addTransition(transitionType: String, transitionSubType: String?)
    {
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType(rawValue: transitionType)
        // transition.subtype = transitionSubType
        self.view.layer.add(transition, forKey: kCATransition)
    }
}
