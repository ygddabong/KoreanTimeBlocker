//
//  CompleteViewController.swift
//  KoreanTimeBlocker
//
//  Created by 송용규 on 21/04/2020.
//  Copyright © 2020 송용규. All rights reserved.
//

import UIKit

class CompleteViewController: UIViewController {
    
    var arriveTime: String?
    var isClickConfirm = false
    var alarmList: Array<Alarm> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updatetime), userInfo: nil, repeats: true)
    }
    
    @objc func updatetime(){
        
        print(arriveTime)
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        var sysDate = formatter.string(from: Date())
        var systemDate = timeFormatter(sysDate)
        
        if isClickConfirm {
            return
        }
        
        for i in 0..<alarmList.count {
            if systemDate == alarmList[i].alarmTime {
                let alert = UIAlertController(title: "Alarm", message: "Time to \(alarmList[i].name!)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: UIAlertAction.Style.default) { UIAlertAction in
                    self.isClickConfirm = true
                    
                    // 60초 후에 timerOn 함수를 실행시키는 타이머
                    Timer.scheduledTimer(timeInterval: 60.0, target: self, selector: #selector(self.timerOn), userInfo: nil, repeats: false)
                })
                self.present(alert, animated: true, completion: nil) // 얼럿 실행
            }
        }
        
    }
    @objc func timerOn() {
        isClickConfirm = false // 초기화
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
