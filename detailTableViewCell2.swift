//
//  detailTableViewCell2.swift
//  csci571
//
//  Created by JIN QU on 26/11/2016.
//  Copyright © 2016 JIN QU. All rights reserved.
//

import UIKit

class detailTableViewCell2: UITableViewCell {
    
    var tapAction: ((UITableViewCell) -> Void)?
    
    @IBOutlet weak var leftText: UILabel!
    @IBAction func rightlink(_ sender: AnyObject) {
        tapAction?(self)
    }
    @IBOutlet weak var rightText: UIButton!

//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
}
