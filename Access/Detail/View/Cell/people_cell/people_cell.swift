//
//  people_cell.swift
//  Access
//
//  Created by Yen on 2020/2/21.
//  Copyright © 2020 Yen. All rights reserved.
//

import UIKit

class people_cell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var lab_cent: NSLayoutConstraint!
    @IBOutlet weak var badge: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        badge.layer.cornerRadius  = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func staff_badge(badge_icon:Bool)
    {
           if(badge_icon)
           {
               lab_cent.constant = -10
                badge.isHidden = false
           }
           else
           {
               lab_cent.constant = 0
               badge.isHidden = true
           }
    }
    
}
