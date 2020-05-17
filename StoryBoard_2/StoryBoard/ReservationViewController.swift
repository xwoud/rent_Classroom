//
//  ReservationViewController.swift
//  StoryBoard
//
//  Created by swuad_14 on 2019. 1. 14..
//  Copyright © 2019년 swuad_14. All rights reserved.
//

import UIKit

class ReservationViewController: UIViewController,UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    let first = ["301호","302호","303호","304호","305호","306호","308호"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return first.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return first[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //OnePicker = self.first[row]
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var OnePicker: UIPickerView!
    
    @IBOutlet weak var TwoPicker: UIPickerView!
    
    @IBOutlet weak var ThreePicker: UIPickerView!
    
    @IBOutlet weak var FourPicker: UIPickerView!
    
    
}
