//
//  rhymeCell.swift
//  RhymeMe
//
//  Created by Mac on 8/24/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

class rhymeCell: UITableViewCell {

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var wordLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
