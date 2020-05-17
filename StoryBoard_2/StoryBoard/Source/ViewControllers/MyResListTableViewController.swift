//
//  MyResListTableViewController.swift
//  StoryBoard
//
//  Created by swuad_14 on 2019. 1. 21..
//  Copyright © 2019년 swuad_14. All rights reserved.
//

import UIKit
import Alamofire

class MyResListTableViewController: UITableViewController {
    let userInfo = UserDefaults.standard
    let cellIdentifier: String = "searchCell"
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rsvList.count
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let idnumber = self.rsvList[indexPath.row].id
            self.rsvList.remove(at: indexPath.row)
            print(idnumber)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            var request: URLRequest
            var URL = "http://kmj.codegrapher.io/reservation/reservation/"+String(idnumber!)+"/"
            print(URL)
            do {
                request = try URLRequest(url: URL, method: .delete)
                
            } catch {
                print("request 생성 실패 " + error.localizedDescription)
                return
            }
            Alamofire.request(request).responseData { (response) in
                
                switch response.result {
                case .success(let data): break
                case .failure(let error):
                    print("요청 실패 " + error.localizedDescription)
                    
                    return
                }
    }
    }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ResListTableViewCell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as! ResListTableViewCell
        
       
        let list: Rsv = self.rsvList[indexPath.row]
        print(indexPath.row,list)
        
        cell.classRoomLabel.text = list.classRoom
        cell.rsvDateLabel.text = list.rsvDate
        cell.rsvTimeLabel.text = list.rsvTime
        cell.rsvPeopleLabel.text = list.rsvPeopleNum+"명"
        
        
        
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
        var nums = userInfo.integer(forKey: "useridid")
        var URL = "http://kmj.codegrapher.io/reservation/reservation/?author="+String(nums)
        Alamofire.request(URL).responseData{(response)in
            
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
        
       //self.reverse()
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
