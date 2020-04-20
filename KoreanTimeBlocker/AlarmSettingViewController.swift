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
    var responseTime: String?
    var alarmList: Array<Alarm> = []

    
    
    @IBAction func completeButton(_ sender: Any) {

    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        


        self.navigationItem.title = "Alarm Setting"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addAlarm(_:)))
        if let placeText = responsePlace {
            destinaionTextField.text = placeText
        }
        if let timeText = responseTime {
            expectedTimeTextField.text = "\(timeText)MIN"
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        


    }
    
    @objc func addAlarm(_ sender: UIBarButtonItem) {
        print("pressed AddBtn")
        //self.showAlert(title: "Add Alarm", message: "Set your alarm", vc: self)
        let alert = UIAlertController(title: "Add Alarm", message: "Set your alarm", preferredStyle: .alert)
        alert.addTextField{(textField) in
            textField.placeholder = "Name"
        }
        alert.addTextField{(textField) in
            textField.placeholder = "Time"
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
            newAlarm.time = alarmTime
            self.alarmList.append(newAlarm)
            print("alarmList: \(self.alarmList)")
            DispatchQueue.main.async {
                self.tableView.reloadData();
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))


        self.present(alert, animated: true, completion: nil)
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
        cell.textLabel?.text = "\(alarmTitle ?? "Non title") / time: \(alarmTIme ?? "0")MIN"
        return cell
    }
}

