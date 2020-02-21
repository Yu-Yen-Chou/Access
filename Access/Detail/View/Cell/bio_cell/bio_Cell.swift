//
//  bio_Cell.swift
//  Access
//
//  Created by Yen on 2020/2/20.
//  Copyright © 2020 Yen. All rights reserved.
//

import UIKit

class bio_Cell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        title.lineBreakMode = .byWordWrapping
        title.numberOfLines = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
