//
//  TalkTableViewController.swift
//  StoryBoard
//
//  Created by swuad_14 on 2019. 1. 15..
//  Copyright © 2019년 swuad_14. All rights reserved.
//

import UIKit

class TalkTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundImage = UIImage(named: "진짜배경")
        let imageView:UIImageView = UIImageView(image: backgroundImage)
        self.tableView.backgroundView = imageView
        
        
    }
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }
    
    @IBAction func touchNum(_ sender: UIButton) {
        

    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let cell: UITableViewCell = tableView.cellForRow(at: indexPath) else {
            return
        }
        
        guard let telString: String = cell.detailTextLabel?.text,
            telString.isEmpty == false else {
                return
        }
        
        guard let telURL: URL = URL(string: "telprompt://" + telString) else {
            return
        }
        
        
        if UIApplication.shared.canOpenURL(telURL) {
            UIApplication.shared.open(telURL, options: [:], completionHandler: nil)
            
        }
        
    }


}
