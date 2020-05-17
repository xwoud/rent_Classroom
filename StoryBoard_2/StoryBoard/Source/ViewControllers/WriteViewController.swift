//
//  WriteViewController.swift
//  StoryBoard
//
//  Created by swuad_14 on 2019. 1. 16..
//  Copyright © 2019년 swuad_14. All rights reserved.
//
//  1:1문의 -> 글쓰기

import UIKit
import Alamofire

class WriteViewController: UIViewController {
    
  
    
    @IBOutlet weak var inquereTexts: UITextView!
    
    @IBAction func touchUpCancleButton(_ sender: UIBarButtonItem) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func WriteButtonClick(_ sender: UIBarButtonItem) {
        let valid_elements:[String:UITextView] = ["등록":self.inquereTexts] //이게 옳은건가오?
        
        var empty_elements = Array<String>()
        for (title,elm) in valid_elements {
            if elm.text == "" {
                empty_elements.append(title)
            }
        }
        
        //문의글 인코딩 하는것 같음
        //맞는듯
        guard let inquireText: String = self.inquereTexts.text, let textData: Data = inquireText.data(using: .utf8) else {
            return
        }
        
        //ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
        //  guard let inquireText: String = self.inquereTexts.text, let textData: Data = inquireText.data(using: .utf8) else {
        //       return
        //   }
        //아래가 시간 받아오는거!
        //ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
        var date = Date()
        var cal = Calendar.current
        
        var currentYear = cal.component( .year, from: date)
        var currentMonth = cal.component( .month, from: date)
        var currentDay = cal.component( .day, from: date)
        var currentHour = cal.component( .hour, from: date)
        var currentMinute = cal.component( .minute, from: date)
        var currentSecond = cal.component( .second, from: date)
        
        //var components = cal.dateComponents([.year, .month, .day , .hour, .minute, .second ], from:date)
        
        
        var currentDate = (String(currentYear) + "-" + String(currentMonth) + "-" + String(currentDay) + " " + String(currentHour) + ":" + String(currentMinute) + ":" + String(currentSecond))
        
        //ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
        //오 잘한듯 잘 되는듯 잘 한건가
        //여기까지가 시간
        
        
        
        //요청 보내는 그친구 거 그렇게 한거임
        var request: URLRequest
        
        do {
            request = try URLRequest(url: "http://kmj.codegrapher.io/inquire/reservation/", method: .post)
            
        } catch {
            print("request 생성 실패 " + error.localizedDescription)
            return
        }
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let userInfo = UserDefaults.standard
        var nums = userInfo.integer(forKey: "useridid")
        // User 구조체에 들어가서 username과 kim를 비교해서 그에 맞는 배열에 id구해오기
       
        let textInfo:Post = Post(id: nil, author: nums, text: inquireText, createdDate: currentDate)
        
        //여기서 시간을 보내야 하는데 어떻게 보내야 하는거지?
        //뭔가 더 줘야한다고 민주가 그럤다 근데 그걸 어떻게 주는건지 모르게따
        
        
        let encoder: JSONEncoder = JSONEncoder()
        
        let jsonData: Data
        do {
            jsonData = try encoder.encode(textInfo)
        } catch {
            print("json 데이터 변환 실패" + error.localizedDescription)
            return
        }
        
        request.httpBody = jsonData
        
        Alamofire.request(request).responseData { (response) in
            
            switch response.result {
            case .success(let data):
                
                // data -> 구조체로 바꿔보기
                
                // 구조체 변경 성공하고, 사용자 정보 가져오기 성공하면 그 후에 얼럿 보여주기
                
                
                let alert = UIAlertController(title: "", message: "글이 올라갔습니다.", preferredStyle: .alert)
                let ok = UIAlertAction(title: "확인", style: .default) { (ok) in
                    self.presentingViewController?.dismiss(animated: true, completion: nil)
                    // 확인 누르면 처음 페이지로 돌아가기
                }
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
                return
                
            case .failure(let error):
                print("요청 실패 " + error.localizedDescription)
                return
            }// 스위치 끝
        }
    }
    
}
