//
//  ResTableViewController.swift
//  StoryBoard
//
//  Created by swuad_14 on 2019. 1. 14..
//  Copyright © 2019년 swuad_14. All rights reserved.
//

import UIKit
import Alamofire
class ResTableViewController: UITableViewController,UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    @IBOutlet weak var onePicker: UIPickerView!
    @IBOutlet weak var twoPicker: UIPickerView!
    @IBOutlet weak var threePicker: UIPickerView!
    
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var stepperLabel: UILabel!
    
    
    @IBOutlet weak var cancleButton: UIBarButtonItem!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    var onePickerData = ["선택하세요","301호","302호","303호","304호","305호","306호","308호"]
    var threePickerData = ["선택하세요","9:00 ~ 9:50","10:00 ~ 10:50","11:00 ~ 11:50","12:00 ~ 12:50","13:00 ~ 13:50","14:00 ~ 14:50","15:00 ~ 15:50","16:00 ~ 16:50","17:00 ~ 17:50"]
    var twoPickerData = ["선택하세요"]
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // picker의 값을 선택했을 때 호출되는 메서드
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if (onePicker.selectedRow(inComponent: 0) == 0 || threePicker.selectedRow(inComponent: 0) == 0) || twoPicker.selectedRow(inComponent: 0) == 0 {
            self.addButton.isEnabled = false
        } else {
            self.addButton.isEnabled = true
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView == onePicker) {
            return self.onePickerData.count
        }
        else if (pickerView == threePicker) {
            return self.threePickerData.count
        } else {
            return self.twoPickerData.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView == onePicker) {
            return self.onePickerData[row]
        }
        else if (pickerView == threePicker) {
            return self.threePickerData[row]
        } else {
            return self.twoPickerData[row]
        }
    }
    
    var stepper_before:Int = 1
    var number = 0

    @IBAction func onStepper(_ sender: UIStepper) {
        number = Int(sender.value)
        if stepper_before == 10 && number == 1 {
            sender.value = 10
            number = 10
        } else if stepper_before == 1 && number == 10 {
            sender.value = 1
            number = 1
        }
        self.stepper_before = number
        stepperLabel.text = String(number)+" 명"
    }
    
    // 추가 버튼
    
    @IBAction func addClick(_ sender: UIButton) {
        let one = onePicker.selectedRow(inComponent: 0)
        let two = twoPicker.selectedRow(inComponent: 0)
        let three = threePicker.selectedRow(inComponent: 0)
        // 확인 메세지
        let msg = "\n" + "강의실 : " + onePickerData[one] + "\n" + "날짜 : " + twoPickerData[two] + "\n" + "시간 : " + threePickerData[three] + "\n" + "인원 : " + String(Int(stepper.value)) + "명"
        let alert = UIAlertController(title: "예약 확인", message: msg , preferredStyle: .alert)
        let ok = UIAlertAction(title: "신청", style: .default) { (ok) in
            print("들어옴")
            let userInfo = UserDefaults.standard
            
            var nums = userInfo.integer(forKey: "useridid")
            
            guard let name: String = userInfo.string(forKey: "username"), let nameData: Data = name.data(using: .utf8) else {
                return
            }
            
            guard let room: String = self.onePickerData[one], let roomData: Data = room.data(using: .utf8) else {
                return
            }
 
            guard let author: Int = nums else {
                return
            }
            
            guard let date: String = self.twoPickerData[two], let dateData: Data = date.data(using: .utf8) else {
                return
            }
            
            guard let time: String = self.threePickerData[three], let timeData: Data = time.data(using: .utf8) else {
                return
            }
            guard let num: String = String(Int(self.stepper.value)), let numData: Data = num.data(using: .utf8) else {
                return
            }

            var request: URLRequest
            let resInfo: Rsv = Rsv(name: name, author: nums, classRoom: room, rsvTime: time, rsvDate: date, rsvPeopleNum: num, rsvResult: 0, id: nil)
            do {
                request = try URLRequest(url: "http://kmj.codegrapher.io/reservation/reservation/", method: .post)
                
                
            } catch {
                print("request 생성 실패 " + error.localizedDescription)
                return
            }
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            
            
            
            let encoder: JSONEncoder = JSONEncoder()
            
            let jsonData: Data
            do {
                jsonData = try encoder.encode(resInfo)
            } catch {
                print("json 데이터 변환 실패" + error.localizedDescription)
                return
            }
            request.httpBody = jsonData
            
            Alamofire.request(request).responseData { (response) in
                
                switch response.result {
                case .success(let data):
                    print("요청성공")
                    return
                    
                case .failure(let error):
                    print("요청 실패 " + error.localizedDescription)
                    return
                }
                
                
                
            }
            
            
            let alert2 = UIAlertController(title: "", message: "신청 완료", preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .default) { (ok) in
                
                // 확인 누르면 처음 페이지로 돌아가기
            }
            alert2.addAction(ok)
            self.present(alert2, animated: true, completion: nil)
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel) { (cancel) in
        }

        alert.addAction(ok)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
        
       
 
    }

    // 취소 버튼 ( 초기화 )
    @IBAction func cancleClick(_ sender: UIButton){
        stepper.value = 1
        stepperLabel.text = "1 명"
        self.onePicker.selectRow(0, inComponent: 0, animated: false)
        self.twoPicker.selectRow(0, inComponent: 0, animated: false)
        self.threePicker.selectRow(0, inComponent: 0, animated: false)
        
    }
   

    override func viewDidLoad() {
        super.viewDidLoad()
        stepper.wraps = true
        stepper.autorepeat = true
        stepper.isContinuous = true
        addButton.isEnabled = false
        
        let now = Date()
        // swift 에서    Date로 부터 요일, 날짜 구하기
        let dayInterval: TimeInterval = 24 * 60 * 60
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.init(identifier: "ko-kr")
        dateFormatter.dateStyle = .long
        
        // UNIX TIME STAMP - DATE(Time Interval)
        
        for i in 0...4 {
            let date = Date(timeInterval: dayInterval * TimeInterval(i), since: now)
            let dateString = dateFormatter.string(from: date)
            self.twoPickerData.append(dateString)
        }
        
        self.twoPicker.reloadComponent(0)
        
        
        
    }


   
}
