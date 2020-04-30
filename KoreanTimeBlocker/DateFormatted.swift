//
//  DateFormatted.swift
//  KoreanTimeBlocker
//
//  Created by 송용규 on 26/04/2020.
//  Copyright © 2020 송용규. All rights reserved.
//

import Foundation

    func timeFormatter(_ time: String) -> Int {
        let timeArray = time.components(separatedBy: ":")
        let hour = Int("\(timeArray[0])")  ?? 0
        let min = Int("\(timeArray[1])") ?? 0
        print("min : \(min)")
        let hourToMin = hour * 60
        print("hourToMin : \(hourToMin)")
        let totalMin = hourToMin + min
        print("totalMin : \(totalMin)")
        return totalMin
    }


