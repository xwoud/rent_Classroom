//
//  MyPageTableViewController.swift
//  Alamofire
//
//  Created by swuad_14 on 2019. 1. 16..
//내가 쓴 글 필터링해서 보는 것

import UIKit

class MyPageTableViewController: UITableViewController {
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }
    @IBOutlet weak var idLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundImage = UIImage(named: "진짜배경")
        let imageView:UIImageView = UIImageView(image: backgroundImage)
        self.tableView.backgroundView = imageView
        let userInfo = UserDefaults.standard
        self.idLabel.text = userInfo.string(forKey: "userid")

      
    }

   

   

}
