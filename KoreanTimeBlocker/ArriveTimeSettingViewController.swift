//
//  AlarmAddEditViewController.swift
//  KoreanTimeBlocker
//
//  Created by 송용규 on 23/04/2020.
//  Copyright © 2020 송용규. All rights reserved.
//

import UIKit

import Foundation

class ArriveTimeSettingViewController: UIViewController {
    
    
        override func viewDidLoad() {
            super.viewDidLoad()
    
        }
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBAction func destinationSettingBtn(_ sender: Any) {
        

        
        let dateformatter = DateFormatter()
                dateformatter.timeStyle = .short
        
        var time = dateformatter.string(from: datePicker.date)
        print("time : \(time)")
        var arriveTime = timeFormatter(time)
        
        guard let mapVC = self.storyboard?.instantiateViewController(withIdentifier: "mapViewController") as? ViewController else { return }
        
        mapVC.self.arriveTime = arriveTime
        self.navigationController?.pushViewController(mapVC, animated: true)
        

    }
    

    
    
    
    
}
