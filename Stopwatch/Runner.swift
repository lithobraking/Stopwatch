//
//  Runner.swift
//  Stopwatch
//
//  Created by Marc Allen on 6/21/20.
//  Copyright © 2020 newstar. All rights reserved.
//

import Foundation
import UIKit

class RunnerManager
{
    // MARK: - Data Fields
    
    var runners = 0
    var runnerList: [String] = []

    var lapTimes: [String] = []
    
    // MARK: - Functions
    
    func addRunner(name: String) {
        runnerList.append(name)
        runners += 1
    }
    
    func saveLap(lap: String) {
        lapTimes.append(lap)
    }
    
    func calculateSplit() {
        // do some math
    }
    
    func calculatePace() {
        // do some more math
    }
}
