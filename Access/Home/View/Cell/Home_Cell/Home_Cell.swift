//
//  Home_Cell.swift
//  Movie
//
//  Created by Yen on 2020/2/20.
//  Copyright © 2020 Yen. All rights reserved.
//

import UIKit

class Home_Cell: UITableViewCell {

   
    @IBOutlet weak var lab_center: NSLayoutConstraint!
    @IBOutlet weak var badge: UIView!
    @IBOutlet weak var title_label: UILabel!
    @IBOutlet weak var bg_view: UIView!
    @IBOutlet weak var poster_img: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bg_view.layer.cornerRadius = 8
        bg_view.layer.masksToBounds = false
        bg_view.layer.shadowColor = UIColor.black.cgColor
        bg_view.layer.shadowOpacity = 0.5
        bg_view.layer.shadowOffset = CGSize(width: -1, height: 1)
        
        badge.layer.cornerRadius = 10
        
        poster_img.layer.masksToBounds = true
        poster_img.layer.cornerRadius = poster_img.frame.width/2
       
        title_label.lineBreakMode = .byWordWrapping
        title_label.numberOfLines = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

     
    }
    func staff_badge(badge_icon:Bool)
    {
        if(badge_icon)
        {
            lab_center.constant = -10
             badge.isHidden = false
        }
        else
        {
            lab_center.constant = 0
            badge.isHidden = true
        }
    }
}
