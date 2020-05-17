//
//  DetailViewController.swift
//  StoryBoard
//
//  Created by swuad_14 on 2019. 1. 17..
//  Copyright © 2019년 swuad_14. All rights reserved.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController ,UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 220
        } else {
            return 60
        }
//        return  UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        
        if row == 0 {
        let cell1: ImageTableViewCell = tableView.dequeueReusableCell(withIdentifier: "imagecell" , for: indexPath) as! ImageTableViewCell
        
        
        cell1.classImage.kf.setImage(with: info.image)

        return cell1
            
        } else{
            let cell2: LabelTableViewCell = tableView.dequeueReusableCell(withIdentifier: "labelcell", for: indexPath) as! LabelTableViewCell
            if info.type == "0"{
            if row == 1 {
                cell2.titleLabel.text = "컴퓨터 사양"
                cell2.inLabel.text = info.spec
            } else if row == 2 {
                cell2.titleLabel.text = "설치된 프로그램"
                cell2.inLabel.text = info.program
            } else if row == 3 {
                cell2.titleLabel.text = "사용가능 시간"
                cell2.inLabel.text = info.day
            } else if row == 4 {
                cell2.titleLabel.text = "공지사항"
                cell2.inLabel.text = info.notice
            }
            }else { if row == 1 {
                cell2.titleLabel.text = "사용가능 시간"
                cell2.inLabel.text = info.day
            } else if row == 2 {
                cell2.titleLabel.text = "공지사항"
                cell2.inLabel.text = info.notice
                }
                
            }
            return cell2
            
        }
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if info.type == "0"{
            return 5}else {
            return 3}
    }

    var info: Condition!
 
    @IBOutlet weak var TableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.TableView.dataSource = self
        
        self.TableView.estimatedRowHeight = UITableView.automaticDimension
        self.TableView.rowHeight = UITableView.automaticDimension
    
    }
    


}
