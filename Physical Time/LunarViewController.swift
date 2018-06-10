/**
 - Author:
 Xi Stephen Ouyang
 
 Created for Physical Time, 2018
 */

import UIKit
import SwiftySuncalc

class LunarViewController: UIViewController {
    
    let new_moon = "new_moon.png";
    let waxing_crescent = "waxing_crescent.png";
    let first_quarter = "1st_quarter.png";
    let waxing_gibbous = "waxing_gibbous.png";
    let full_moon = "moon.png";
    let waning_gibbous = "waning_gibbous.png";
    let third_quarter = "third_quarter.png";
    let waning_crescent = "waning_crescent.png";
    
    @IBOutlet weak var countdownLabel2: UILabel!

    @IBOutlet weak var countdownLabel: UILabel!
    
    @IBOutlet weak var currentMoonPhase: UILabel!
    var seconds = 0;
    var timer = Timer();
    let moonPosObj = SwiftySuncalc();
    var moonDict: [String: Double] = [:]
    
    var currentTime: Date {
        return Date()
    }
    
    func getNextEclipse()-> Int {
        
        let calendar = Calendar.current;
        var dateComponent = DateComponents();
        
        dateComponent.second = 54;
        dateComponent.hour = 8;
        dateComponent.minute = 22;
        dateComponent.month = 7;
        dateComponent.day = 27;
        dateComponent.year = 2018;
        let julyEclipse = calendar.date(from: dateComponent as DateComponents)!
        
        var secUntilJulyEclipse = julyEclipse.timeIntervalSince1970;
        var julyEclipseInt = Int(secUntilJulyEclipse);
        return julyEclipseInt;
    }
    
    func secondsUntilNextEclipse() {
        
        let julyEclipse = getNextEclipse();
        //print("\(julyEclipse)")
        
        var timeInterval = currentTime.timeIntervalSince1970;
        var currentTimeAsInt = Int(timeInterval);
        
        var nextEclipse = julyEclipse - currentTimeAsInt;
        seconds = nextEclipse;
    }
    
    func timeString(time:TimeInterval) -> String {
        
        let hours = Int(time) / 3600 % 24
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i:%02i", hours, minutes, seconds);
    }
    
    func timeString2(time:TimeInterval) -> String {
        
        let months = Int(time) / (3600 * 24 * 30) % 12
        let days = Int(time) / (3600 * 24) % 30
        
        if (months == 1 && days == 1)
        {
            return "\(months) month and \(days) day"
        }
        else if (months == 1)
        {
            return "\(months) month and \(days) days"
        }
        else if (days == 1)
        {
            return "\(months) months and \(days) day"
        }
        else
        {
            return "\(months) months and \(days) days"
        }
    }
    
    func getMoonData() -> Dictionary<String, Double> {
        var dict: [String: Double] = [:]
        dict = moonPosObj.getMoonIllumination(date: currentTime)
        print("This is the console output: \(dict as AnyObject)")
        return dict
    }
    
    func getLunarCycle() -> UIImageView {
        var dict: [String: Double] = [:]
        dict = getMoonData()
        //print(dict["phase"]!);
        var phase = dict["phase"];
        
        var someImage = UIImage();
        var someImageView = UIImageView();
        
        switch phase {
        case let x where x! <= 0.125:
            someImage = UIImage(named: new_moon)!;
            someImageView = UIImageView(image: someImage);
            currentMoonPhase.text = "New Moon"
            break;
        case let x where x! >= 0.126 && x! <= 0.25:
            someImage = UIImage(named: waxing_crescent)!;
            someImageView = UIImageView(image: someImage);
            currentMoonPhase.text = "Waxing Crescent"
            break;
        case let x where x! >= 0.251 && x! <= 0.375:
            someImage = UIImage(named: first_quarter)!;
            someImageView = UIImageView(image: someImage);
            currentMoonPhase.text = "First Quarter"
            break;
        case let x where x! >= 0.376 && x! <= 0.50:
            someImage = UIImage(named: waxing_gibbous)!;
            someImageView = UIImageView(image: someImage);
            currentMoonPhase.text = "Waxing Gibbous"
            break;
        case let x where x! >= 0.51 && x! <= 0.625:
            someImage = UIImage(named: full_moon)!;
            someImageView = UIImageView(image: someImage);
            currentMoonPhase.text = "Full Moon"
            break;
        case let x where x! >= 0.626 && x! <= 0.750:
            someImage = UIImage(named: waning_gibbous)!;
            someImageView = UIImageView(image: someImage);
            currentMoonPhase.text = "Waning Gibbous"
            break;
        case let x where x! >= 0.751 && x! <= 0.875:
            someImage = UIImage(named: third_quarter)!;
            someImageView = UIImageView(image: someImage);
            currentMoonPhase.text = "Third Quarter"
            break;
        case let x where x! >= 0.876 && x! <= 1:
            someImage = UIImage(named: waning_crescent)!;
            someImageView = UIImageView(image: someImage);
            currentMoonPhase.text = "Waning Crescent"
            break;
        default:
            print("error");
            break;
        }
        return someImageView;
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(LunarViewController.updateTimer), userInfo: nil, repeats: true);
    }
    
    @objc func updateTimer() {
        
        seconds -= 1;
        if seconds >= 0 {
            countdownLabel.text = timeString(time: TimeInterval(seconds));
            countdownLabel2.text = timeString2(time: TimeInterval(seconds));
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage:UIImage(named: "lunar_pic")!)
        var moonImage = UIImageView();
        secondsUntilNextEclipse();
        runTimer();
        moonDict = getMoonData()
        moonImage = getLunarCycle()
        moonImage.frame = CGRect(x: 98, y: 144, width: 200, height: 200);
        view.addSubview(moonImage);
        
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
