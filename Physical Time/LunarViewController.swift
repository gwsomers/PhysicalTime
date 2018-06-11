import UIKit
import SwiftySuncalc
import SwiftSoup

class LunarViewController: UIViewController {
    
    var document: Document = Document.init("")
    // All the UI components for this display
    @IBOutlet weak var lunarEclipseLabel: UILabel!
    @IBOutlet weak var countdownLabel: UILabel!
    @IBOutlet weak var currentMoonPhase: UILabel!
    // Class variables for our class
    var seconds = 0;
    var timer = Timer();
    
    
    struct eclipseData {
        var min: Int
        var hour: Int
        var day: Int
        var month: Int
        var year: Int
    }
    
    
    func getEclipseData()->String {
        var eclipseString = ""
        let url = URL(string: "https://www.timeanddate.com/eclipse/in/usa/los-angeles")
        do {
            // content of url
            let html = try String.init(contentsOf: url!)
            // parse it into a Document
            document = try SwiftSoup.parse(html)
            // parse css query
        } catch _ {
        }
        do
        {
            let elements: Elements = try document.select("div.h3")
            let text = try elements.text()
            print(text)
            eclipseString = text;
        }
        catch _ {
        }
        print(eclipseString)
        return eclipseString
    }
    
    
    func parseEclipseString() -> [String] {
        let eclipseString = getEclipseData()
        var eclipseStringArray = eclipseString.components(separatedBy: " ")
        //print("\(eclipseStringArray[1])")
        
        
        let dayOfMonthString = eclipseStringArray[1]
        let indexOfString = dayOfMonthString.index(dayOfMonthString.startIndex, offsetBy: 2)
        let daySubstring = dayOfMonthString[..<indexOfString]
        //print("\(daySubstring)")
        eclipseStringArray[1] = String(daySubstring)
        print("\(eclipseStringArray)")
        return eclipseStringArray
    }
    
    
    func convertString() -> eclipseData {
        
        
        var stringArr = parseEclipseString()
        let monthString = stringArr[0]
        var monthInt: Int = 0;
        let day = Int(stringArr[1])
        let year = Int(stringArr[2])
        
        
        var hourAndMinArr = stringArr[4].components(separatedBy: ":")
        //print("\(hourAndMinArr)")
        
        
        var hour = Int(hourAndMinArr[0])
        let min = Int(hourAndMinArr[1])
        
        
        if(stringArr[5] == "pm"){
            hour! += 12
        }
        
        
        switch monthString {
        case "Jan":
            monthInt = 1
        case "Feb":
            monthInt = 2
        case "Mar":
            monthInt = 3
        case "Apr":
            monthInt = 4
        case "May":
            monthInt = 5
        case "Jun":
            monthInt = 6
        case "Jul":
            monthInt = 7
        case "Aug":
            monthInt = 8
        case "Sep":
            monthInt = 9
        case "Oct":
            monthInt = 10
        case "Nov":
            monthInt = 11
        case "Dec":
            monthInt = 12
        default:
            monthInt = 0
        }
        
        
        let data = eclipseData(min: min!, hour: hour!, day: day!, month: monthInt, year: year!)
        return data
    }
    
    
    func getNextEclipse() -> Int
    {
        
        
        let calendar = Calendar.current;
        var dateComponent = DateComponents();
        
        
        let eclipseData = convertString()
        
        
        dateComponent.second = 0;
        dateComponent.hour = eclipseData.hour;
        dateComponent.minute = eclipseData.min;
        dateComponent.month = eclipseData.month;
        dateComponent.day = eclipseData.day;
        dateComponent.year = eclipseData.year;
        let Eclipse = calendar.date(from: dateComponent as DateComponents)!
        
        
        let secUntilEclipse = Eclipse.timeIntervalSince1970;
        let EclipseInt = Int(secUntilEclipse);
        return EclipseInt;
    }
    
    
    func secondsUntilNextEclipse() {
        let Eclipse = getNextEclipse();
        
        
        let timeInterval = Date().timeIntervalSince1970;
        let currentTimeAsInt = Int(timeInterval);
        
        
        let nextEclipse = Eclipse - currentTimeAsInt;
        seconds = nextEclipse;
    }
    
    
    func countdownString(time: TimeInterval) -> String
    {
        let hours = Int(time) / 3600 % 24
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i:%02i", hours, minutes, seconds);
    }
    
    /**
     Helper function to display the amount of months and days
     
     - returns:
     A mutable string to initialize the labels.
     */
    func lunarEclipseStringGenerator(time: TimeInterval) -> String
    {
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
    
    /**
     Using the SwiftySuncalc library, we can determine the lunar phase based on the
     value given and initialize a `UIImageView` object with the object initialized
     to the correct moon to be displayed.
     
     - returns:
     Void
     */
    func initLunarCycleImage() -> Void
    {
        // Get the lunar phase based on today's date
        let phase = SwiftySuncalc()
                        .getMoonIllumination(date: Date())["phase"]
        // Initialize the lunar image view to be an empty `UIImageView` object
        // with no pictures initialized
        var lunarImageView = UIImageView();
        
        // Switch statement to determine which phase we're in, and initializes
        // the empty `lunarImageView` and the `currentMoonPhase` label view and
        // text
        switch phase
        {
            case let x where x! <= 0.125:
                lunarImageView = UIImageView(image:
                                    UIImage(named: "new_moon.png")!);
                currentMoonPhase.text = "New Moon"
                break;
            case let x where x! >= 0.126 && x! <= 0.25:
                lunarImageView = UIImageView(image:
                                    UIImage(named: "waxing_crescent.png")!)
                currentMoonPhase.text = "Waxing Crescent"
                break;
            case let x where x! >= 0.251 && x! <= 0.375:
                lunarImageView = UIImageView(image:
                                    UIImage(named: "1st_quarter.png")!);
                currentMoonPhase.text = "First Quarter"
                break;
            case let x where x! >= 0.376 && x! <= 0.50:
                lunarImageView = UIImageView(image:
                                    UIImage(named: "waxing_gibbous.png")!);
                currentMoonPhase.text = "Waxing Gibbous"
                break;
            case let x where x! >= 0.51 && x! <= 0.625:
                lunarImageView = UIImageView(image:
                                    UIImage(named: "moon.png")!);
                currentMoonPhase.text = "Full Moon"
                break;
            case let x where x! >= 0.626 && x! <= 0.750:
                lunarImageView = UIImageView(image:
                                UIImage(named: "waning_gibbous.png")!);
                currentMoonPhase.text = "Waning Gibbous"
                break;
            case let x where x! >= 0.751 && x! <= 0.875:
                lunarImageView = UIImageView(image:
                                UIImage(named: "third_quarter.png")!);
                currentMoonPhase.text = "Third Quarter"
                break;
            case let x where x! >= 0.876 && x! <= 1:
                lunarImageView = UIImageView(image:
                                UIImage(named: "waning_crescent.png")!);
                currentMoonPhase.text = "Waning Crescent"
                break;
            default:
                break;
        }
        lunarImageView.frame = CGRect(x: 98, y: 144, width: 200, height: 200);
        view.addSubview(lunarImageView);
    }
    
    
    func runTimer()
    {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(LunarViewController.updateTimer), userInfo: nil, repeats: true);
    }
    
    /**
     Helper function that runs at a scheduled time interval to update the labels
     according to the time.
     
     - returns:
     Void
     */
    @objc func updateTimer()
    {
        // Decrease the seconds value
        seconds -= 1;
        if seconds >= 0
        {
            countdownLabel.text = countdownString(time: TimeInterval(seconds));
            lunarEclipseLabel.text = lunarEclipseStringGenerator(
                                    time: TimeInterval(seconds));
        }
        else
        {
            // TODO: Reset all values and UI elements to display the next
            // image
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(
                                    patternImage: UIImage(named: "lunar_pic")!)
        secondsUntilNextEclipse()
        runTimer()
        initLunarCycleImage()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
