//
//  FirstTableViewCell.swift
//  StoryBoard
//
//  Created by swuad_14 on 2019. 1. 11..
//  Copyright © 2019년 swuad_14. All rights reserved.
//

import UIKit

class FirstTableViewCell: UITableViewCell {

    @IBOutlet var classLabel: UILabel!
    @IBOutlet var computerImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
