
//
//  DetailViewController.swift
//  StoryBoard
//
//  Created by swuad_14 on 2019. 1. 17..
//  Copyright © 2019년 swuad_14. All rights reserved.
//예약 리스트 클릭 시 디테일 페이지

import UIKit
import Kingfisher

class ResListDetailTableViewController: UIViewController,UITableViewDataSource {
    
    @IBOutlet var detailTable : UITableView!
    
    let detailurl: String = "http://kmj.codegrapher.io/reservertion/reservation/"
    var reservationInfo : Rsv!

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ReListDetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: "reservationDetailcell", for: indexPath) as! ReListDetailTableViewCell
        
        let row = indexPath.row
        
        if row == 0 {
            cell.reservationTitle.text = "예약자 이름"
            cell.detail.text = reservationInfo.name
        }else if row == 1{
            cell.reservationTitle.text = "예약 강의실"
            cell.detail.text = reservationInfo.classRoom
        }else if row == 2{
            cell.reservationTitle.text = "예약 날짜"
            cell.detail.text = reservationInfo.rsvDate
            
        }else if row == 3{
            cell.reservationTitle.text = "예약 시간"
            cell.detail.text = reservationInfo.rsvTime
        }else if row == 4{
            cell.reservationTitle.text = "예약 인원 수"
            cell.detail.text = reservationInfo.rsvPeopleNum
        } else  {
            cell.reservationTitle.text = "신청 확인"
            if reservationInfo.rsvResult == 0 {
                cell.detail.text = "확인중"
            } else {
                cell.detail.text = "예약 완료"
            }
            
        }
        
        return cell
    }
   
    override func viewDidLoad() {
        self.detailTable.dataSource = self
        print(self.reservationInfo)
    }
}
