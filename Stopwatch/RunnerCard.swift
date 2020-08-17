//
//  RunnerCard.swift
//  Stopwatch
//
//  Created by Marc Allen on 8/6/20.
//  Copyright © 2020 newstar. All rights reserved.
//

import UIKit

class RunnerCard: UITableViewCell {
    
    @IBOutlet weak var runnerCardView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lastLapLabel: UILabel!
    @IBOutlet weak var splitLabel: UILabel!
    @IBOutlet weak var paceLabel: UILabel!
    
    func newRunner(name: String) {
        nameLabel.text = name
        // card view
        runnerCardView.layer.cornerRadius = 6.0
        runnerCardView.layer.masksToBounds = true
        // card view shadow
        runnerCardView.layer.shadowColor = UIColor.gray.cgColor
        runnerCardView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        runnerCardView.layer.shadowOpacity = 1.0
        runnerCardView.layer.masksToBounds = false
        runnerCardView.layer.cornerRadius = 2.0
    }
}
