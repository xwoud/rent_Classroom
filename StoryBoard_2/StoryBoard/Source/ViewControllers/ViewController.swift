//
//  ViewController.swift
//  StoryBoard
//
//  Created by swuad_14 on 2019. 1. 8..
//  Copyright © 2019년 swuad_14. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITextFieldDelegate {

    
    var log: [User] = []
    
    @IBOutlet weak var idText: UITextField!{ didSet {idText.delegate = self } }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        idText.resignFirstResponder()
        return true
        }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
            self.view.endEditing(true)
        }
    
    
    
    @IBOutlet weak var pwText: UITextField!
    
    
    @IBAction func loginButton(_ sender: Any) {
        // user 구조체에서 id 비교하기
        self.loadDataFromWeb()
        
        }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    
    }

   
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
                            self.idText.text = ""
                            self.pwText.text = ""
                            self.present(tabbarController, animated: true, completion: nil)
                            let userInfo = UserDefaults.standard
                            userInfo.set(self.log[i].username, forKey: "userid")
                            userInfo.set(self.log[i].name, forKey: "username")
                            userInfo.set(self.log[i].dept, forKey: "userdept")
                            userInfo.set(self.log[i].id, forKey: "useridid")
                            userInfo.set(self.log[i].studentID, forKey: "usernum")
                            
                            userInfo.synchronize()
                            
                           
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
                        if num == self.log.count {
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
 
}
