//
//  SignUpViewController.swift
//  StoryBoard
//
//  Created by swuad_14 on 2019. 1. 16..
//  Copyright © 2019년 swuad_14. All rights reserved.
//

import UIKit
import Alamofire

class SignUpViewController: UIViewController {

    @IBOutlet var signView: UIView!
    @IBOutlet weak var idText: UITextField! //id
    @IBOutlet weak var pw1Text: UITextField! //비번
    @IBOutlet weak var pw2Text: UITextField! // 비번확인
    @IBOutlet weak var numText: UITextField! // 학번
    @IBOutlet weak var deptText: UITextField! // 학과
    @IBOutlet weak var nameText: UITextField! // 이름
    
    // 취소버튼
    @IBAction func touchUpCancleButton(_ sender: UIButton) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }

    
    @IBAction func SignUpClick(_ sender: UIButton) {//가입하기 버튼 눌렀을때
        let valid_elements:[String:UITextField] = ["id":self.idText,"비밀번호":self.pw1Text,"비밀번호 확인":self.pw2Text,"학번":self.numText,"학과":self.deptText,"이름":self.nameText]
        var empty_elements = Array<String>()
        for (title,elm) in valid_elements {
            if elm.text == "" {
                empty_elements.append(title)
            }
        }
        if empty_elements.count > 0 { // 항목이 비었을때
            let message = empty_elements.joined(separator: ",") + "\n" +  "항목을 채워주세요"
            let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
            // action애 실행코드에 추가해줄 코드
            let ok = UIAlertAction(title: "확인", style: .default) { (ok) in
                
            }
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
            //self.idText.becomeFirstResponder()
            return
        } else { // 항목이 다 채워졌을때
            
            if pw1Text.text != pw2Text.text { // 비밀번호와 비밀번호 확인이 다를때
                let alert = UIAlertController(title: "", message: "비밀번호가 일치하지 않습니다", preferredStyle: .alert)
                let ok = UIAlertAction(title: "확인", style: .default) { (ok) in
                }
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
                return
            } else { // 드디어 가입 완료
                //아이디
                guard let id: String = self.idText.text, let idData: Data = id.data(using: .utf8) else {
                    return
                }
                // 비밀번호
                guard let pw: String = self.pw1Text.text, let pwData: Data = pw.data(using: .utf8) else {
                    return
                }
                //학번
                guard let num: String = self.numText.text, let numData: Data = num.data(using: .utf8) else {
                    return
                }
                //학과
                guard let dept: String = self.deptText.text, let deptData: Data = dept.data(using: .utf8) else {
                    return
                }
                //이름
                guard let name: String = self.nameText.text, let nameData: Data = name.data(using: .utf8) else {
                    return
                }
                var request: URLRequest
                
                do {
                    request = try URLRequest(url: "http://kmj.codegrapher.io/accounts/accounts/", method: .post)
                    
                } catch {
                    print("request 생성 실패 " + error.localizedDescription)
                    return
                }
                
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
                let userInfo: User = User(username: id, password: pw, name: name, dept: dept, studentID: num, id: nil)
                
                let encoder: JSONEncoder = JSONEncoder()
                
                let jsonData: Data
                do {
                    jsonData = try encoder.encode(userInfo)
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
                        
                        
                        let alert = UIAlertController(title: "", message: "가입이 완료되었습니다 ^^", preferredStyle: .alert)
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
                    }
                    
                    
                    
                }

                
            }
        }
  
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        signView.layer.cornerRadius = 7
        //signView.layer.borderWidth = 1
        // Do any additional setup after loading the view.
    }
    


}
