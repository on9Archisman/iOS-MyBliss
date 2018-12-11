//
//  CommonFunction.swift
//  MyBliss
//
//  Created by Archisman Banerjee on 08/12/18.
//  Copyright © 2018 Archisman Banerjee. All rights reserved.
//

import Foundation
import UIKit

class Helper
{
    // MARK: HEX CODE TO UICOLOR
    static func hexStringToUIColor(HexCode: String) -> UIColor
    {
        var cString:String = HexCode.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#"))
        {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6)
        {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    // MARK: API CALL WITH GET/POST
    static func callAPIWithDataTask(param: String, method: String, data: NSDictionary?, completionHandler: @escaping (Bool, AnyObject?) -> ())
    {
        let urlString: String = "\(baseURL+param)"
        print("Step to URL 1 => ", urlString)
        
        let urlwithPercentEscapes = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        print("Step to URL 2 => ", urlwithPercentEscapes!)
        
        let liveUrl = URL(string: urlwithPercentEscapes!)
        print("Step to URL 3 => ", liveUrl!)
        
        var request = URLRequest(url: liveUrl!)
        request.httpMethod = method.uppercased()
        
        if (method.uppercased() == "POST")
        {
            request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
            
            if (data != nil)
            {
                do
                {
                    let httpBody = try JSONSerialization.data(withJSONObject: data!, options: [])
                    
                    request.httpBody = httpBody
                }
                catch let error as NSError
                {
                    print(error.localizedDescription)
                }
            }
        }
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            
            if (error != nil)
            {
                print(error!.localizedDescription)
                
                completionHandler(false, nil)
            }
            else
            {
                if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode
                {
                    do
                    {
                        let json = try JSONSerialization.jsonObject(with: data!, options: [])
                        completionHandler(true, json as AnyObject)
                    }
                    catch
                    {
                        completionHandler(false, nil)
                    }
                }
                else
                {
                    completionHandler(false, nil)
                }
            }
        }
        
        dataTask.resume()
    }
}
