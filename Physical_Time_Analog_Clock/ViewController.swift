//
//  ViewController.swift
//  Physical_Time_Analog_Clock
//
//  Created by Xi Stephen Ouyang on 2/17/18.
//  Copyright © 2018 Xi Stephen Ouyang. All rights reserved.
//

import UIKit

/* TODO
   Make minute hand - done
   Allow customization of clock hand initialization - done
   Fix rotation issue (backward rotation)
   Have rotations mimic actual clock rotation. Alter the duration**
 */

class ViewController: UIViewController {
    
    var timer = Timer()
    let partHand = Create_Rect(frame: CGRect(x: 185.8, y: 258, width: 4.5, height: 68))
    let tickHand = Create_Rect(frame: CGRect(x: 185.8, y: 225, width: 4.5, height: 135))
    let anglePosition = Hand_Positioner(pPD: 24, pRPD: 2, tPP: 60, tRPP: 1, fRO: 0, tRO: 0)

    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(ViewController.updateTimer), userInfo: nil, repeats: true)
    }

    @objc func updateTimer(){
        updatePartHand()
        updateTickHand()
    }

    func initHandPos() {
        partHandPos()
        tickHandPos()
    }

    func partHandPos() {
        partHand.transform = CGAffineTransform(rotationAngle: CGFloat(self.anglePosition.partAngle(timeHour: 12, timeMin: 0, timeSec: 0)))
    }

    func tickHandPos() {
        tickHand.transform = CGAffineTransform(rotationAngle: CGFloat(self.anglePosition.tickAngle(timeHour: 12, timeMin: 0, timeSec: 0)))
    }

    func updateTickHand() {
        UIView.animate(withDuration: 5, delay:0, options: .curveLinear, animations: ({
            self.tickHand.transform = CGAffineTransform(rotationAngle: CGFloat(self.anglePosition.tickAngle(timeHour: 3, timeMin: 20, timeSec: 0)))
        }))
    }

    func updatePartHand() {
        UIView.animate(withDuration: 2, delay:0, options: .curveLinear, animations: ({
            self.partHand.transform = CGAffineTransform(rotationAngle: CGFloat(self.anglePosition.partAngle(timeHour: 3, timeMin: 20, timeSec: 0)))
        }))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(partHand)
        view.addSubview(tickHand)
        partHand.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        tickHand.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        
        //DEBUG statement
        print("\(anglePosition.partAngle(timeHour: 3, timeMin: 0, timeSec: 0))")
        
        initHandPos()
        startTimer()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

