//
//  AskTableViewController.swift
//  StoryBoard
//
//  Created by swuad_14 on 2019. 1. 15..
//  Copyright © 2019년 swuad_14. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher


class ResListAskTableViewController: UITableViewController {
    
    
    //var log: [User] = []
    
    let cellIdentifier: String = "searchCell"
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rsvList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ResListTableViewCell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as! ResListTableViewCell
        
        print("a")
        let list: Rsv = self.rsvList[indexPath.row]
        print(self.rsvList[indexPath.row])

        cell.classRoomLabel.text = list.classRoom
        cell.nameLabel.text = list.name
        cell.rsvDateLabel.text = list.rsvDate
        if list.rsvResult == 0 {
            cell.rsvImage.image = UIImage(named: "question")
        } else {
            cell.rsvImage.image = UIImage(named: "check")
        }
        
        
        
        return cell
        
    }
    
    //테이블 뷰에 텍스트 리스트를 가져와야...겠지?
    //textList는 테이블 뷰!
    @IBOutlet var textViewList:UILabel!
    //정보를 담아둘 배열
    //textList는 배열!
    var rsvList:[Rsv]=[]  //
    //Post는 내가 가져올 정보?
    
    //텍스트 인포 받아오려는듯
    @objc func requestTextInfos(){
        Alamofire.request("http://kmj.codegrapher.io/reservation/reservation/").responseData{(response)in
            
            self.tableView.refreshControl?.endRefreshing()
            if let error:Error=response.error{
                print("네트워크 요청 보류 발생")
                print(error.localizedDescription)
                return
            }
            
            guard let data:Data=response.data else{
                print("data 없음")
                return
            }
            
            let decoder:JSONDecoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do{
                self.rsvList=try
                    decoder.decode([Rsv].self, from: data)     //ImageInfo -> Post
                self.tableView.reloadData()
            } catch{
                print("JSON 디코드 오류 발생")
                print(error.localizedDescription)
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.requestTextInfos()
        
        
        let refreshControl:UIRefreshControl=UIRefreshControl()
        
        refreshControl.addTarget(self, action: #selector(self.requestTextInfos), for: UIControl.Event.valueChanged)
        
        self.tableView.refreshControl=refreshControl
        
        self.tableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender:Any?){
        
        guard let cell: UITableViewCell = sender as? UITableViewCell else {
            return
        }
        
        guard let index:IndexPath = self.tableView.indexPath(for: cell) else {
            return
        }
        
        //여기를 수정해야 할 것 같은데
        //목적지가 없어서 이  아래는 x
        
        guard let dest = segue.destination as? ResListDetailTableViewController else {
            return
        }
        dest.reservationInfo = self.rsvList[index.row]
        
    }
    
}



/*
 @objc func loadDataFromWeb() {
 
 // 웹에 JSON 데이터 요청
 Alamofire.request("http://kmj.codegrapher.io/accounts/accounts/").responseData { (response) in
 
 // 웹에서 응답이 왔을대 실행될 부분
 
 if let error = response.error {
 print(error.localizedDescription)
 print("오류발생")
 return
 }
 
 // 전송받은 데이터가 있는지 확인하여 꺼내오기
 guard let data: Data = response.data else {
 print("데이터 없음")
 return
 }
 
 // JSON 데이터를 구조체 형식으로 변환해줄 디코더
 let decoder: JSONDecoder = JSONDecoder()
 decoder.keyDecodingStrategy = JSONDecoder.KeyDecodingStrategy.convertFromSnakeCase
 
 //데이터를 JSON으로 변환
 do {
 self.log = try decoder.decode([User].self, from: data)
 var num = 0
 for i in 0...self.log.count-1 {
 if self.idText.text == self.log[i].username
 {
 if self.pwText.text == self.log[i].password{
 
 guard let tabbarController = self.storyboard?.instantiateViewController(withIdentifier: "MainTabbarController") as? UITabBarController else {
 return
 }
 self.present(tabbarController, animated: true, completion: nil)
 break
 }
 else{
 let alert = UIAlertController(title: "", message: "비밀번호를 체크하세요", preferredStyle: .alert)
 let ok = UIAlertAction(title: "확인", style: .default) { (ok) in
 // 확인 누르면 처음 페이지로 돌아가기
 }
 alert.addAction(ok)
 self.present(alert, animated: true, completion: nil)
 break
 }
 }else{
 num += 1
 if num == 3 {
 let alert = UIAlertController(title: "", message: "없는 아이디 입니다", preferredStyle: .alert)
 let ok = UIAlertAction(title: "확인", style: .default) { (ok) in
 // 확인 누르면 처음 페이지로 돌아가기
 }
 alert.addAction(ok)
 self.present(alert, animated: true, completion: nil)
 }
 
 }
 }
 // 없는아이디입니다.
 
 
 } catch {
 
 // 변환에 실패하면 알림
 print("JSON 디코드 실패")
 print(error.localizedDescription)
 }
 
 
 }
 }
 
 }*/

