//
//  AlarmSettingViewController.swift
//  KoreanTimeBlocker
//
//  Created by 송용규 on 17/04/2020.
//  Copyright © 2020 송용규. All rights reserved.
//

import UIKit

class AlarmSettingViewController: UIViewController {
    
    @IBOutlet weak var destinaionTextField: UILabel!
    @IBOutlet weak var expectedTimeTextField: UILabel!
    
    var responsePlace: String?
    var responseTime: Int?
    var alarmList: Array<Alarm> = []
    var departureTime: String?
    var arriveTime: Int?
    
    var pickerView = UIDatePicker()
    
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Alarm Setting"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addAlarm(_:)))
        if let placeText = responsePlace {
            destinaionTextField.text = placeText
        }
        if let timeText = responseTime {
            let hour = timeText / 60
            let min = timeText % 60
            
            if hour != 0 {
                expectedTimeTextField.text = "\(hour)Hour \(min)MIN"
            } else {
                expectedTimeTextField.text = "\(min)MIN"
            }
            expectedTimeTextField.textColor = .red
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.rowHeight = 60
    }

    @objc func addAlarm(_ sender: UIBarButtonItem) {
                print("pressed AddBtn")
                let alert = UIAlertController(title: "Add Alarm", message: "Set your alarm", preferredStyle: .alert)
                alert.addTextField{(textField) in
                    textField.placeholder = "Name"
                }
                alert.addTextField{(textField) in
                    textField.placeholder = "Time"
                    textField.keyboardType = .numberPad
                }
        
        
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler:{
                    (action: UIAlertAction) in
                    guard let alarmName = alert.textFields![0].text else {return}
                    guard let alarmTime = alert.textFields![1].text else {return}
        
                    print("alarmName : \(alarmName)")
                    print("alarmTime: \(alarmTime)")
        
                    let newAlarm = Alarm()
                    newAlarm.uuid = UUID().uuidString
                    newAlarm.name = alarmName
                    newAlarm.time = Int(alarmTime)
                    self.alarmList.append(newAlarm)
                    print("alarmList: \(self.alarmList)")
                    DispatchQueue.main.async {
                        self.tableView.reloadData();
                    }
                }))
                alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        
        
                self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func completeButton(_ sender: Any) {
        print("Clicked completeButton")
        var totalTime = 0
        for alarm in alarmList {
            var alarmTime = alarm.time ?? 0
            totalTime += alarmTime
        }
        
        for i in 0..<alarmList.count {
            if i == 0 {
                alarmList[i].alarmTime = self.arriveTime! - totalTime
                    - responseTime!
            } else {
                alarmList[i].alarmTime = alarmList[i-1].alarmTime! + alarmList[i].time!
            }
            if alarmList[i].alarmTime! <= 0 {
                alarmList[i].alarmTime = alarmList[i].alarmTime ?? 0 + 1440
            }
        }
        
        print(alarmList)
        
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "CompleteViewController") as? CompleteViewController else { return }
        //vc.arriveTime = self.arriveTime
        vc.alarmList = self.alarmList
        self.present(vc, animated: true, completion: nil)
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

extension AlarmSettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return alarmList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let alarmTitle = alarmList[indexPath.row].name
        let alarmTIme = alarmList[indexPath.row].time
        cell.textLabel?.text = "\(alarmTitle ?? "Non title") / time: \(alarmTIme ?? 0)MIN"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            alarmList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .bottom)
        }
    }
}

