//
//  MyListTableViewController.swift
//  StoryBoard
//
//  Created by swuad_14 on 2019. 1. 21..
//  Copyright © 2019년 swuad_14. All rights reserved.
//

import UIKit
import Alamofire

class MyListTableViewController: UITableViewController {
    
    let cellIdentifier: String = "searchCell"
    var textList:[Post]=[]
    let userInfo = UserDefaults.standard
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.textList.count
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let idnumber = self.textList[indexPath.row].id
            self.textList.remove(at: indexPath.row)
            //   self.tableView.remove(at : indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            var request: URLRequest
            let URL = "http://kmj.codegrapher.io/inquire/reservation/"+String(idnumber!)+"/"
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
        let cell: ListTableViewCell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as! ListTableViewCell

        let list: Post = self.textList[indexPath.row]
        cell.inLabel.text = list.text
       // cell.dateLabel.text = list.createdDate
        
        let time = list.createdDate
        let index = time.index(time.startIndex, offsetBy: 10)
        let hi = time[..<index]
        cell.dateLabel.text = String(hi)
        
  
        cell.idLabel.text = userInfo.string(forKey: "userid")
        
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.requestTextInfos()
        let refreshControl:UIRefreshControl=UIRefreshControl()
        
        refreshControl.addTarget(self, action: #selector(self.requestTextInfos), for: UIControl.Event.valueChanged)
        
        self.tableView.refreshControl=refreshControl
        
        self.tableView.dataSource = self
     
    }

    @objc func requestTextInfos(){
        
        var nums = userInfo.integer(forKey: "useridid")
        var URL = "http://kmj.codegrapher.io/inquire/reservation/?author="+String(nums)
    
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
                self.textList=try
                    decoder.decode([Post].self, from: data)     //ImageInfo -> Post
                self.tableView.reloadData()
            } catch{
                print("JSON 디코드 오류 발생")
                print(error.localizedDescription)
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender:Any?){
        
        guard let cell: UITableViewCell = sender as? UITableViewCell else {
            return
        }
        
        guard let index:IndexPath = self.tableView.indexPath(for: cell)else{
            return
        }
    }
  
}
