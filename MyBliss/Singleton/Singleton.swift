//
//  Singleton.swift
//  MyBliss
//
//  Created by Archisman Banerjee on 08/12/18.
//  Copyright © 2018 Archisman Banerjee. All rights reserved.
//

import Foundation

final class Singleton
{
    static let shared = Singleton()
    
    private init() { }
    
    // Local Variable
    var owner: String = "Archisman Banerjee"
}
