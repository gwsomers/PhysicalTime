//
//  ViewController.swift
//  Physical_Time_Analog_Clock
//
//  Created by Xi Stephen Ouyang on 2/17/18.
//  Copyright © 2018 Xi Stephen Ouyang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var clockImage: UIImageView!
    var timer: Timer?
    
    let f = Create_Rect(frame: CGRect(x: 184.8, y: 226, width: 4.5, height: 135))
    
    @objc func rotateHand() {
        UIView.animate(withDuration: 1, delay: 0, options: [.repeat], animations: ({
            self.f.transform = CGAffineTransform(rotationAngle: 0.60)
        }))
    }
    
    func startTimer() {
        guard timer == nil else { return }
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(rotateHand), userInfo: nil, repeats: true)
    }
    
    func stopTimer() {
        guard timer != nil else { return }
        timer?.invalidate()
        timer = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(f)
        //stopTimer()
        f.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        rotateHand()
        // startTimer()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

