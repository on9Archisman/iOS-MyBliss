//
//  ListTableViewCell.swift
//  MyBliss
//
//  Created by Archisman Banerjee on 08/12/18.
//  Copyright © 2018 Archisman Banerjee. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell
{
    @IBOutlet weak var viewOuter: UIView!
    @IBOutlet weak var viewDate: UIView!
    @IBOutlet weak var viewDateShadow: UIView!
    @IBOutlet weak var labelDateMonth: UILabel!
    @IBOutlet weak var labelDateYear: UILabel!
    @IBOutlet weak var labelDateDay: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        self.backgroundColor = UIColor.clear
        viewOuter.backgroundColor = UIColor.clear
        
        viewDate.layer.borderWidth = 1
        viewDate.layer.cornerRadius = 5
        viewDate.layer.borderColor = UIColor.clear.cgColor
        viewDate.layer.masksToBounds = true
        
        viewDateShadow.backgroundColor = UIColor.clear
        viewDateShadow.layer.borderWidth = 1
        viewDateShadow.layer.borderColor = UIColor.clear.cgColor
        viewDateShadow.layer.shadowOpacity = 0.7
        viewDateShadow.layer.shadowOffset = CGSize(width: 3, height: 3)
        viewDateShadow.layer.shadowRadius = 4
        viewDateShadow.layer.shadowColor = UIColor.black.cgColor
        viewDateShadow.layer.masksToBounds = false
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }
}
