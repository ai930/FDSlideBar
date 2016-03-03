//
//  TableViewCell.swift
//  FDSlideBarSwift
//
//  Created by 蒋林源 on 16/3/3.
//  Copyright © 2016年 蒋林源. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}