//
//  StopwatchViewController.swift
//  Stopwatch
//
//  Created by Marc Allen on 6/20/20.
//  Copyright © 2020 newstar. All rights reserved.
//

import UIKit

class StopwatchViewController: UIViewController, UITextFieldDelegate
{
    // General UI outlets
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var runnerTableView: UITableView!
    
    // Runner card outlets
    @IBOutlet weak var addRunnerButton: UIButton!
    @IBOutlet weak var addRunnerTextbox: UITextField!
    
    var runners: [String] = []
    
    // MARK: - Timer
    var timer = Timer()
    var isTimerRunning = false
    var counter = 0.00
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timerLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 60, weight: .regular)
        startButton.isEnabled = true
        startButton.layer.cornerRadius = startButton.bounds.width / 2.0
        startButton.layer.masksToBounds = true
        
        resetButton.isEnabled = false
        resetButton.layer.cornerRadius = resetButton.bounds.width / 2.0
        resetButton.layer.masksToBounds = true
        
    }
    
    @IBAction func startDidTap(_ sender: Any) {
        if !isTimerRunning {
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(runTimer), userInfo: nil, repeats: true)
            isTimerRunning = true
            
            startButton.setTitle("Stop", for: .normal)
            startButton.backgroundColor = UIColor.systemRed
            
            startButton.isEnabled = true
            resetButton.isEnabled = false
            
        } else if isTimerRunning {
            isTimerRunning = false
            timer.invalidate()
            
            startButton.setTitle("Start", for: .normal)
            startButton.backgroundColor = UIColor.systemGreen
            
            resetButton.isEnabled = true
        }
    }
    
    @IBAction func resetDidTap(_ sender: Any) {
        if !isTimerRunning {
            isTimerRunning = false
            timer.invalidate()
            counter = 0.00
            timerLabel.text = "00:00.00"
            
            startButton.isEnabled = true
            resetButton.isEnabled = false
            
        }
    }
    
    //MARK: - Timer method
    @objc
    func runTimer() {
        counter += 0.01
        
        // HH:MM:SS.dd
        let flooredCounter = Int(floor(counter))
        
        let hour = flooredCounter / 3600
        var hourString = "\(hour)"
        if hour < 10 {
            hourString = "0\(hour)"
        }
        
        let minute = (flooredCounter % 3600) / 60
        var minuteString = "\(minute)"
        if minute < 10 {
            minuteString = "0\(minute)"
        }
        
        let second = (flooredCounter % 3600) % 60
        var secondString = "\(second)"
        if second < 10 {
            secondString = "0\(second)"
        }
        
        let decisecond = String(format: "%.2f", counter).components(separatedBy: ".").last!
        
        if hour == 0 {
            timerLabel.text = "\(minuteString):\(secondString).\(decisecond)"
        }
        else if hour > 0 {
            timerLabel.text = "\(hourString):\(minuteString):\(secondString).\(decisecond)"
        }
    }
    
    //MARK: - Runner Methods
    
    @IBAction func addButtonTapped(_ sender: Any) {
        if counter == 0 && addRunnerTextbox.text != "" {
            addNewRunner()
        }
    }
    
    func addNewRunner() {
        runners.append(addRunnerTextbox.text!)
        let indexPath = IndexPath(row: runners.count - 1, section: 0)
        
        runnerTableView.beginUpdates()
        runnerTableView.insertRows(at: [indexPath], with: .automatic)
        runnerTableView.endUpdates()
        
        addRunnerTextbox.text = ""
        view.endEditing(true)
    }
    
}

// MARK: - Table View

extension StopwatchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return runners.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "runnerCard", for: indexPath) as! RunnerCard

        cell.newRunner(name: runners[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            runners.remove(at: indexPath.row)
            
            runnerTableView.beginUpdates()
            runnerTableView.deleteRows(at: [indexPath], with: .automatic)
            runnerTableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // when a cell is tapped, execute fuction from RunnerCard() class
        // that saves the lap into an array
    }

}
