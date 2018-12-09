//
//  ListViewController.swift
//  MyBliss
//
//  Created by Archisman Banerjee on 08/12/18.
//  Copyright © 2018 Archisman Banerjee. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet weak var viewImageOuter: UIView!
    @IBOutlet weak var imageViewLogo: UIImageView!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var viewActivity: UIView!
    @IBOutlet weak var tableViewList: UITableView!
    
    var gradientLayer = CAGradientLayer()
    
    var arrayFetchResult = NSArray()
    
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
        tableViewList.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        
        viewActivity.isHidden = false
        
        Helper.callAPIWithDataTask(param: "api/v1/dummy?page=1", method: "get", data: nil) { (flag, result) in
            
            print("Response Flag =",flag)
            
            DispatchQueue.main.async {
                self.viewActivity.isHidden = true
            }
            
            if (flag)
            {
                let dictJSON = result as! NSDictionary
                
                print("Result =",dictJSON)
                
                if let data = dictJSON["data"] as? NSDictionary
                {
                    if let episodes = data["episodes"] as? NSArray
                    {
                        self.arrayFetchResult = episodes
                        
                        if (self.arrayFetchResult.count > 0)
                        {
                            DispatchQueue.main.async {
                                
                                self.tableViewList.isHidden = false
                                self.tableViewList.reloadData()
                            }
                        }
                        else
                        {
                            DispatchQueue.main.async {
                                self.actionSheetAsAlert(message: "No records available, Please try again")
                            }
                        }
                    }
                    else
                    {
                        DispatchQueue.main.async {
                            self.actionSheetAsAlert(message: "No records available, Please try again")
                        }
                    }
                }
                else
                {
                    DispatchQueue.main.async {
                        self.actionSheetAsAlert(message: "No records available, Please try again")
                    }
                }
            }
            else
            {
                DispatchQueue.main.async {
                    self.actionSheetAsAlert(message: "Something went wrong, Please try again")
                }
            }
        }
    }
    
    override func viewWillLayoutSubviews()
    {
        super.viewWillLayoutSubviews()
        
        gradientLayer.frame = view.layer.bounds
        
        // self.setGradientLayer(gradientLayer: gradientLayer, firstColor: UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 1), secondColor: "429ED8" as AnyObject)
        
        self.setGradientLayer(gradientLayer: gradientLayer, firstColor: "FF9D2D" as AnyObject, secondColor: UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 1))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arrayFetchResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell: ListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "REUSE") as! ListTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 115
        // return UITableView.automaticDimension
    }
    
    /*
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 150
    }
    */
    
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
