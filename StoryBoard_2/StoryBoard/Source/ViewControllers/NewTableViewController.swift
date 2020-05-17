//
//  NewTableViewController.swift
//  StoryBoard
//
//  Created by swuad_14 on 2019. 1. 21..
//  Copyright © 2019년 swuad_14. All rights reserved.
//

import UIKit

class NewTableViewController: UITableViewController {

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }
    @IBOutlet weak var idLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundImage = UIImage(named: "배경2")
        let imageView:UIImageView = UIImageView(image: backgroundImage)
        self.tableView.backgroundView = imageView
        
        
        
    }
    
    

}
