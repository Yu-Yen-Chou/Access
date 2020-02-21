//
//  detail_cell.swift
//  Access
//
//  Created by Yen on 2020/2/21.
//  Copyright © 2020 Yen. All rights reserved.
//

import UIKit

class detail_cell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var icon_img: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
