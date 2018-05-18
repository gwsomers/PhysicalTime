//
//  FeatureViewController.swift
//  Physical_Time_Analog_Clock
//
//  Created by Xi Stephen Ouyang on 5/4/18.
//  Copyright © 2018 Xi Stephen Ouyang. All rights reserved.
//

import UIKit

class FeatureViewController: UIViewController {
    
    @IBOutlet weak var lunarFeatureButton: UIButton!
    @IBOutlet weak var wadokeiFeatureButton: UIButton!
    @IBOutlet weak var planetaryVisButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let background = changeBackground()
        self.view.backgroundColor = UIColor(patternImage:UIImage(named: background.getBackground())!)

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let background = changeBackground()
        self.view.backgroundColor = UIColor(patternImage:UIImage(named: background.getBackground())!)
        
        switch background.getBackground() {
        case "sunrise.jpg":
            lunarFeatureButton.setTitleColor(UIColor.orange, for: .normal);
            wadokeiFeatureButton.setTitleColor(UIColor.orange, for: .normal);
            planetaryVisButton.setTitleColor(UIColor.orange, for: .normal);
        case "morningGoldenHour.jpg":
            lunarFeatureButton.setTitleColor(UIColor.yellow, for: .normal);
            wadokeiFeatureButton.setTitleColor(UIColor.yellow, for: .normal);
            planetaryVisButton.setTitleColor(UIColor.yellow, for: .normal);
        case "noon.jpg":
            lunarFeatureButton.setTitleColor(UIColor.yellow, for: .normal);
            wadokeiFeatureButton.setTitleColor(UIColor.yellow, for: .normal);
            planetaryVisButton.setTitleColor(UIColor.yellow, for: .normal);
        case "sunset.jpg":
            lunarFeatureButton.setTitleColor(UIColor.orange, for: .normal);
            wadokeiFeatureButton.setTitleColor(UIColor.orange, for: .normal);
            planetaryVisButton.setTitleColor(UIColor.orange, for: .normal);
        case "night.jpg":
            lunarFeatureButton.setTitleColor(UIColor.orange, for: .normal);
            wadokeiFeatureButton.setTitleColor(UIColor.orange, for: .normal);
            planetaryVisButton.setTitleColor(UIColor.orange, for: .normal);
        case "lunar_pic.jog":
            lunarFeatureButton.setTitleColor(UIColor.white, for: .normal);
            wadokeiFeatureButton.setTitleColor(UIColor.white, for: .normal);
            planetaryVisButton.setTitleColor(UIColor.white, for: .normal);
        default:
            lunarFeatureButton.setTitleColor(UIColor.black, for: .normal);
            wadokeiFeatureButton.setTitleColor(UIColor.black, for: .normal);
            planetaryVisButton.setTitleColor(UIColor.black, for: .normal);
        }
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
