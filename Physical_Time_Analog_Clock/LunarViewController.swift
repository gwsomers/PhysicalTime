//
//  LunarViewController.swift
//  Physical_Time_Analog_Clock
//
//  Created by Xi Stephen Ouyang on 5/23/18.
//  Copyright © 2018 Xi Stephen Ouyang. All rights reserved.
//

import UIKit

class LunarViewController: UIViewController {
    
    //TODO: Get the current time, get the next lunar eclipse time, and subtract.
    
    @IBOutlet weak var countdownLabel: UILabel!
    var seconds = 360000;
    var timer = Timer();
    var currentTime: Date {
        return Date()
    }
    
    
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i:%02i", hours, minutes, seconds);
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(LunarViewController.updateTimer), userInfo: nil, repeats: true);
    }
    
    @objc func updateTimer() {
        
        var timeInterval = currentTime.timeIntervalSince1970;
        var currentTimeAsInt = Int(timeInterval);
        print("\(currentTimeAsInt)");
        
        seconds -= 1;
        if seconds >= 0 {
            countdownLabel.text = timeString(time: TimeInterval(seconds));
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage:UIImage(named: "lunar_pic")!)
        runTimer();
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

