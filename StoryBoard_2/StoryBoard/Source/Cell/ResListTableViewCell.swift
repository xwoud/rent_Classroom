//
//  ListTableViewCell.swift
//  StoryBoard
//
//  Created by swuad_14 on 2019. 1. 18..
//  Copyright © 2019년 swuad_14. All rights reserved.
//

import UIKit

class ResListTableViewCell: UITableViewCell {
   
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var classRoomLabel: UILabel!
    @IBOutlet weak var rsvDateLabel: UILabel!
    
    @IBOutlet weak var rsvImage: UIImageView!
    @IBOutlet weak var rsvPeopleLabel: UILabel!
    @IBOutlet weak var rsvTimeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
