//
//  SearchViewController.swift
//  StoryBoard
//
//  Created by swuad_14 on 2019. 1. 11..
//  Copyright © 2019년 swuad_14. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher


class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var lists: [Condition] = []
    @IBOutlet var tableView:UITableView!
    let cellIdentifier: String = "searchCell"
 
    
    // section에 해당하는 row의 수를 알려줄 메서드
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.lists.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FirstTableViewCell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as! FirstTableViewCell
        
        
        let list: Condition = self.lists[indexPath.row]
        
        cell.classLabel.text = list.name
        let font = UIFont(name:"InterGTOTFL", size : 17)
        //cell.classLabel
        if list.type == "0" {
            cell.computerImageView.image = UIImage(named: "laptop")
        } else {
            cell.computerImageView.image = UIImage(named: "책상")
        }
        
        
        return cell
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // ViewController가 tableView에게 데이터를 주겠다
        self.tableView.dataSource = self
        self.tableView.delegate = self
        // 웹에 데이터 요청
        self.loadDataFromWeb()
        
        //테이블 뷰 새로고침 컨트롤러
        let refreshControl: UIRefreshControl = UIRefreshControl()
        // 새로고침 할 때 호출할 메서드 추가
        refreshControl.addTarget(self, action: #selector(self.loadDataFromWeb), for: UIControl.Event.valueChanged)
        
        // 뺑글이 색깔 바꿔보기
        refreshControl.tintColor = UIColor.blue
        
        // 테이브륩의 새로고침 동작에 넣어줌
        self.tableView.refreshControl = refreshControl
        
        let backgroundImage = UIImage(named: "배경2")
        let imageView:UIImageView = UIImageView(image: backgroundImage)
        self.tableView.backgroundView = imageView
        
        
        
        
                            
        
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // sender가 ContactTableViewCell인지 확인
        guard let cell: FirstTableViewCell = sender as?
            FirstTableViewCell else {
                print("segue를 작동시킨 것이 FirstTableViewCell이 아님")
                return
        }
        
        guard let index: IndexPath = self.tableView.indexPath(for: cell)
            else {
                print("cell의 index를 찾을 수 없음")
                return
        }
        
        // cell에 index에 해당하는 연락처 정보를 연락처 정보 배열에서 꺼내옴
        let list: Condition = self.lists[index.row]
        
        // 목적지 view controller (DetailViewController)를 확인하여 가져옴
        guard let destination: DetailViewController =
            segue.destination as? DetailViewController else {
                print("목적지가 DetailViewController가 아님")
                return
        }
        
        // 목적지 view controller에게 정보전달
        destination.info = list
    }
    
    
    @objc func loadDataFromWeb() {
        
        // 웹에 JSON 데이터 요청
        Alamofire.request("http://kmj.codegrapher.io/condition/").responseData { (response) in
            
            // 웹에서 응답이 왔을대 실행될 부분
            
            // 뺑글이 멈추기
            self.tableView.refreshControl?.endRefreshing()
            
            
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
                
                // 변환에 성공하면 테이블뷰의 데이터 배열에 넣어줌
                self.lists = try decoder.decode([Condition].self, from: data)
                
                // 테이블뷰가 읽어올 데이터가 갱신되었으니 테이블뷰를 새로고침
                self.tableView.reloadData()
                
            } catch {
                // 변환에 실패하면 알림
                print("JSON 디코드 실패")
                print(error.localizedDescription)
            }
            
            
        }
    }
    
}
