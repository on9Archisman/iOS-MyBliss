//
//  ListViewController.swift
//  MyBliss
//
//  Created by Archisman Banerjee on 08/12/18.
//  Copyright © 2018 Archisman Banerjee. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate
{
    @IBOutlet weak var viewImageOuter: UIView!
    @IBOutlet weak var imageViewLogo: UIImageView!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var searchBarList: UISearchBar!
    @IBOutlet weak var viewActivity: UIView!
    @IBOutlet weak var tableViewList: UITableView!
    
    var gradientLayer = CAGradientLayer()
    
    let refreshControl = UIRefreshControl()
    
    var arrayFetchResult = NSArray()
    var arrayFetchResultFilter = NSMutableArray()
    
    var pageNumber = Int()
    
    var isSearch: Bool = false
    {
        didSet
        {
            print("The value of myProperty changed from \(oldValue) to \(isSearch)")
        }
    }
    
    var skipPagination: Bool = false
    
    // MARK: ViewController LifeCycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.clear
        
        // Heading Image
        addShadowToHeaderContent()
        
        // Date
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d, yyyy"
        let result = formatter.string(from: date)
        labelDate.text = result
        
        // Loader
        viewActivity.layer.cornerRadius = 10
        viewActivity.clipsToBounds = true
        view.bringSubviewToFront(viewActivity)
        
        // Navigation & Viewcontroller
        let VCArray:Array = (self.navigationController?.viewControllers)!
        var arrVC = VCArray
        print("Before Delete VC =",arrVC)
        
        for i in 0..<VCArray.count
        {
            if VCArray[i].isKind(of: self.classForCoder)
            {
                break
            }
            else
            {
                arrVC.removeFirst()
            }
        }
        
        print("After Delete VC =",arrVC)
        self.navigationController?.viewControllers = arrVC
        
        tableViewList.tableFooterView = UIView()
        
        // Refresh Control
        refreshControl.tintColor = UIColor.white
        refreshControl.addTarget(self, action: #selector(refreshPage), for: .valueChanged)
        if #available(iOS 10.0, *)
        {
            tableViewList.refreshControl = refreshControl
        }
        else
        {
            // Fallback on earlier versions
            tableViewList.addSubview(refreshControl)
        }
        
        // Search Bar
        let textFieldInsideSearchBar = searchBarList.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = UIColor.white
        textFieldInsideSearchBar?.setValue(UIColor.white, forKeyPath: "_placeholderLabel.textColor")
        let textFieldInsideSearchBarImage: UIImageView = textFieldInsideSearchBar?.leftView as! UIImageView
        textFieldInsideSearchBarImage.image = textFieldInsideSearchBarImage.image?.withRenderingMode(.alwaysTemplate)
        textFieldInsideSearchBarImage.tintColor = UIColor.white
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        pageNumber = 1
        
        viewActivity.isHidden = false
        view.isUserInteractionEnabled = false
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        
        searchBarList.text = ""
        isSearch = false
        
        Helper.callAPIWithDataTask(param: "api/v1/dummy?page=\(pageNumber)", method: "get", data: nil) { (flag, result) in
            
            print("Response Flag =",flag)
            
            DispatchQueue.main.async {
                self.viewActivity.isHidden = true
                self.view.isUserInteractionEnabled = true
            }
            
            if (flag)
            {
                let dictJSON = result as! NSDictionary
                
                print("Result =",dictJSON)
                
                if let data = dictJSON["data"] as? NSDictionary
                {
                    if let episodes = data["episodes"] as? NSArray
                    {
                        if (self.pageNumber == 1)
                        {
                            self.arrayFetchResult = episodes
                        }
                        else
                        {
                            if (episodes.count > 0)
                            {
                                let temp: NSMutableArray = self.arrayFetchResult.mutableCopy() as! NSMutableArray
                                temp.addObjects(from: episodes as! [Any])
                                self.arrayFetchResult = temp
                            }
                            else
                            {
                                self.pageNumber = self.pageNumber - 1
                                
                                DispatchQueue.main.async {
                                    self.actionSheetAsAlert(message: "No records available, All are fetched")
                                }
                            }
                        }
                        
                        if (self.arrayFetchResult.count > 0)
                        {
                            DispatchQueue.main.async {
                                
                                self.tableViewList.reloadData()
                                self.tableViewList.layoutIfNeeded()
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
        
        self.setGradientLayer(gradientLayer: gradientLayer, firstColor: "429ED8" as AnyObject, secondColor: UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 1))
    }
    
    @objc func refreshPage()
    {
        // Code to refresh table view
        refreshControl.endRefreshing()
        
        pageNumber = 1
        
        viewActivity.isHidden = false
        view.isUserInteractionEnabled = false
        
        skipPagination = true
        
        viewDidAppear(true)
    }
    
    // MARK: UISearchbar Delegate
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar)
    {
        // isSearch = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar)
    {
        searchBar.resignFirstResponder()
        // isSearch = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar)
    {
        searchBar.resignFirstResponder()
        // isSearch = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        searchBar.resignFirstResponder()
        // isSearch = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        print("Text Count =",searchText.count)
        
        if (searchText.count == 0)
        {
            isSearch = false
            tableViewList.reloadData()
            tableViewList.layoutIfNeeded()
        }
        else
        {
            arrayFetchResultFilter.removeAllObjects()
            
            for i in 0 ..< arrayFetchResult.count
            {
                let dictObject = arrayFetchResult[i] as! NSDictionary
                
                if let title = dictObject["title"] as? String
                {
                    if title.lowercased().range(of: searchText.lowercased()) != nil
                    {
                        arrayFetchResultFilter.add(dictObject)
                    }
                }
            }
            
            isSearch = true
            tableViewList.reloadData()
            tableViewList.layoutIfNeeded()
        }
    }
    
    // MARK: UITableView Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if (isSearch)
        {
            return arrayFetchResultFilter.count
        }
        else
        {
            return arrayFetchResult.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell: ListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "REUSE") as! ListTableViewCell
        
        var dictObject = NSDictionary()
        
        if (isSearch)
        {
            dictObject = arrayFetchResultFilter[indexPath.row] as! NSDictionary
        }
        else
        {
            dictObject = arrayFetchResult[indexPath.row] as! NSDictionary
        }
        
        if let date = dictObject["date"] as? String
        {
            let arrayDate = date.components(separatedBy: "-")
            
            cell.labelDateDay.text = arrayDate[2]
            
            cell.labelDateMonth.text = DateFormatter().shortMonthSymbols[Int(arrayDate[1])!-1]
            
            cell.labelDateYear.text = arrayDate[0]
        }
        else
        {
            cell.labelDateDay.text = "TBA"
            cell.labelDateMonth.text = "TBA"
            cell.labelDateYear.text = "TBA"
        }
        
        if let smallImageUrl = dictObject["smallImageUrl"] as? String
        {
            cell.imageViewLink.imageFromServerURL(smallImageUrl, placeHolder: UIImage.init(named: "logoMyBliss"))
        }
        else
        {
            cell.imageViewLink.image = UIImage.init(named: "logoMyBliss")
        }
        
        if let title = dictObject["title"] as? String
        {
            cell.labelTitle.text = title
        }
        else
        {
            cell.labelTitle.text = "TBA"
        }
        
        cell.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
        
        UIView.animate(withDuration: 0.3, animations: {
            
            cell.layer.transform = CATransform3DMakeScale(1.05,1.05,1)
            
        },completion: { finished in
            
            UIView.animate(withDuration: 0.1, animations: {
                
                cell.layer.transform = CATransform3DMakeScale(1,1,1)
            })
        })
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        // return UITableView.automaticDimension
        return 115
    }
    
    /*
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 150
    }
    */
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        var dictObject = NSDictionary()
        
        if (isSearch)
        {
            dictObject = arrayFetchResultFilter[indexPath.row] as! NSDictionary
        }
        else
        {
            dictObject = arrayFetchResult[indexPath.row] as! NSDictionary
        }
        
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        detailVC.dictFetchResult = dictObject
        
        self.navigationController?.push(VC: detailVC)
    }
    
    // MARK: Pagination
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool)
    {
        if (skipPagination == false )
        {
            if (isSearch == false)
            {
                if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height)
                {
                    pageNumber = pageNumber + 1
                    
                    viewActivity.isHidden = false
                    view.isUserInteractionEnabled = false
                    
                    viewDidAppear(true)
                }
            }
        }
        else
        {
            skipPagination = false
        }
    }
    
    // MARK: Miscellaneous
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
