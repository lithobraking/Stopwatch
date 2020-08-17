//
//  Runner.swift
//  Stopwatch
//
//  Created by Marc Allen on 6/21/20.
//  Copyright © 2020 newstar. All rights reserved.
//

import Foundation
import UIKit

class Runner: StopwatchViewController {
    // MARK: - Initialization Fields
    var name: String!
    var currentLap: Int = 0
    var lastLap: String?
    var laps: [String] = []
    var totalLapCount = 0
    
    func runner(name: String) {
        self.name = name
    }
    
    // MARK: - Methods
    
    func milliToString(lapMilli: Int) -> String {
        // convert milliseconds into MM:SS.mm format
        var formattedLap: String!
        
        let hour = lapMilli / 3600
        var hourString = "\(hour)"
        if hour < 10 {
            hourString = "0\(hour)"
        }
        
        let minute = (lapMilli % 3600) / 60
        var minuteString = "\(minute)"
        if minute < 10 {
            minuteString = "0\(minute)"
        }
        
        let second = (lapMilli % 3600) % 60
        var secondString = "\(second)"
        if second < 10 {
            secondString = "0\(second)"
        }
        
        let decisecondString = String(format: "%.2f", counter).components(separatedBy: ".").last!
        
        if hour == 0 {
            formattedLap = "\(minuteString):\(secondString).\(decisecondString)"
        }
        else if hour > 0 {
            formattedLap = "\(hourString):\(minuteString):\(secondString).\(decisecondString)"
        }
        
        return formattedLap
    }
    
    func calculateSplit(lastLapMilli: Int, currentLapMilli: Int) -> Int {
        let splitMilli = currentLapMilli - lastLapMilli
        return splitMilli
    }
    
    func calculatePace(laps: [Int]) -> Int{
        var lapTotal = 0
        for lap in laps {
            lapTotal += laps[lap]
        }
        let pace = lapTotal / laps.count
        return pace
    }
    
    // MARK: - Helper Methods
    
    func addLap() {
        laps.append(timerLabel.text!)
        lastLap = timerLabel.text
    }
    
    func clearAllLaps() {
        laps.removeAll()
    }
    
}
