/*

This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike
4.0 International License, by Yong Bakos.

*/

import UIKit

class ViewController: UIViewController {
   
    @IBOutlet weak var timeLabel: UILabel!
    
    var timer: Timer?
    let clock = Clock()
    var test: Timer?

    //my branch 
    override func viewDidLoad() {
        super.viewDidLoad()
        NSLog("You fucking degenerate")
        
//        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.updateTimeLabel), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.updateTimeLabel), userInfo: nil, repeats: true)
        
    }
    
    @objc func updateTimeLabel() {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        timeLabel.text = "\(formatter.string(from: clock.currentTime as Date))"
        timeLabel.textColor = UIColor.cyan
    }
    
//    deinit {
//        NotificationCenter.default.removeObserver(self)
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateTimeLabel()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer?.invalidate()
    }
}

