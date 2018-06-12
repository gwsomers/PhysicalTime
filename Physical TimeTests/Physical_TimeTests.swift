/**
 - Author:
 Cristian Gonzales
 
 Created for Physical Time, 2018
 */

import XCTest
import CoreLocation
@testable import Physical_Time

/**
 TODO: Missing `ViewController`, `ClockFace`, `WadokeiFace`, `WadokeiViewController` (must be refactored and
 properly modularized before being tested under scope
 */
class Physical_TimeTests: XCTestCase
{
    // Instantiation of each class
    var changeBackground: ChangeBackground!
    var featureViewController: FeatureViewController!
    var handFormulas: HandFormulas!
    var lunarViewController: LunarViewController!
    var menuInfoViewController: MenuInfoViewController!
    var menuViewController: MenuViewController!
    var planetsPopUpViewController: PlanetsPopUpViewController!
    var settingsClipoboardViewController: SettingsClipboardViewController!
    var settingsViewController: SettingsViewController!
    var statsViewController: StatsViewController!
    var transferSettings: TransferSettings!
    var wadokeiInfoViewController: WadokeiInfoViewController!
    var welcomeViewController: WelcomeViewController!
    
    /**
     Initializing class variables previously declared that are under scope
     */
    override func setUp()
    {
        super.setUp()
        changeBackground = ChangeBackground()
        featureViewController = FeatureViewController()
        handFormulas = HandFormulas()
        lunarViewController = LunarViewController()
        menuInfoViewController = MenuInfoViewController()
        menuViewController = MenuViewController()
        planetsPopUpViewController = PlanetsPopUpViewController()
        settingsClipoboardViewController = SettingsClipboardViewController()
        settingsViewController = SettingsViewController()
        statsViewController = StatsViewController()
        transferSettings = TransferSettings()
        wadokeiInfoViewController = WadokeiInfoViewController()
        welcomeViewController = WelcomeViewController()
    }
    
    /**
     Initializing class variables back to null
     */
    override func tearDown()
    {
        changeBackground = nil
        featureViewController = nil
        handFormulas = nil
        lunarViewController = nil
        menuInfoViewController = nil
        menuViewController = nil
        planetsPopUpViewController = nil
        settingsClipoboardViewController = nil
        settingsViewController = nil
        statsViewController = nil
        transferSettings = nil
        wadokeiInfoViewController = nil
        welcomeViewController = nil
        super.tearDown()
    }
    
    /**
     Testing one method call
     */
    func testChangeBackground()
    {
        let backgroundName: String = changeBackground.getBackground()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        // Getting date components year, month, day
        let date = Date()
        let year = Calendar.current.component(.year, from: date)
        let month = Calendar.current.component(.month, from: date)
        let day = Calendar.current.component(.day, from: date)
        // Constructing the string for "today"
        let today = String(year) + "/" + String(month) + "/" + String(day)
        // Getting the date object for `today`
        let someDate = formatter.date(from: today)
        // Instantiating the Solar function to get the sunrise and sunset times
        let coords = CLLocationCoordinate2D.init(
            latitude: Singletons.coords.latitude,
            longitude: Singletons.coords.longitude
        )
        let solar = Solar.init(for: someDate!, coordinate: coords)
        let sunrise = solar!.sunrise!
        let sunset = solar!.sunset!
        // Getting the interval Date objects
        let sunriseInterval = sunrise.timeIntervalSince1970
        let sunsetInterval = sunset.timeIntervalSince1970
        let daytime = sunsetInterval - sunriseInterval
        let timeInterval = date.timeIntervalSince1970
        
        let oneHourInSeconds: Double = 3600.0
        // Switch statement to determine what time of the day it is, and thus we can
        // dynamically give the name of the background to the caller
        switch (timeInterval)
        {
        case let timeInterval where timeInterval < sunriseInterval:
            XCTAssertEqual(backgroundName, "lunar_pic.jpg", "Picture values do not match!")
        case let timeInterval where timeInterval > sunriseInterval
            && timeInterval < (sunriseInterval + oneHourInSeconds):
            XCTAssertEqual("sunrise.jpg", backgroundName, "Picture values do not match!")
        case let timeInterval where timeInterval > sunriseInterval +
            oneHourInSeconds && timeInterval < (sunriseInterval + daytime / 2):
            XCTAssertEqual("morningGoldenHour.jpeg", backgroundName, "Picture values do not match!")
        case let timeInterval where timeInterval > (sunriseInterval + daytime / 2)
            && timeInterval < (sunsetInterval - daytime/4):
            XCTAssertEqual("noon.jpg", backgroundName, "Picture values do not match!")
        case let timeInterval where timeInterval > (sunsetInterval - daytime / 4) &&
            timeInterval < sunsetInterval:
            XCTAssertEqual("evening.jpg", backgroundName, "Picture values do not match!")
        case let timeInterval where timeInterval > sunsetInterval &&
            timeInterval < (sunsetInterval + oneHourInSeconds):
            XCTAssertEqual("sunset.jpg", backgroundName, "Picture values do not match!")
        case let timeInterval where timeInterval > (sunsetInterval + oneHourInSeconds):
            XCTAssertEqual("lunar_pic.jpg", backgroundName, "Picture values do not match!")
        default:
            XCTAssertEqual("morningGoldenHour.jpeg", backgroundName, "Picture values do not match!")
        }
    }
    
    /**
     Testing the `FeatureViewController`
     */
    func testFeatureViewController()
    {
        // Create a UI button to test setting the font color
        let button: UIButton = UIButton()
        featureViewController.setFontColor(button: button, backgroundType: "lunar_pic.jpg")
        XCTAssertEqual(UIColor.white, button.currentTitleColor, "Colors do not match!")
    }
    
    /**
     Testing the HandFormulas() helper method
     */
    func testHandFormulas()
    {
        // Approximate the hour angle and test accordingly
        let hourAngle: Float = handFormulas.hourAngle(timeHour: 3,
                                                      timeMin: 20, timeSec: 40)
        XCTAssertEqual(Double(1.75), Double(round(hourAngle * 100) / 100),
                       "Hour angles not equal!")
        // Test the hour duration
        let hourDuration: Int = handFormulas.hourDuration()
        XCTAssertEqual(43200, hourDuration, "The hour duration values are not equal!")
        // Test the minute angle
        let minuteAngle: Float = handFormulas.minuteAngle(timeHour: 3,
                                                          timeMin: 20, timeSec: 40)
        XCTAssertEqual(2.16, round(minuteAngle * 100) / 100,
                       "The minute angle values are not equal!")
        // Test the duration of one minute
        let minuteDuration: Int = handFormulas.minuteDuration()
        XCTAssertEqual(3600, minuteDuration, "Minute duration values are not equal!")
        // Test the mode offset function
        let modeOffset: Int = handFormulas.getModeOffset()
        XCTAssertEqual(0, modeOffset, "Mode offset values are not equal!")
        // Test the `getFullDay()` function
        let fullDayVal: Int = handFormulas.getFullDay()
        XCTAssertEqual(86400, fullDayVal, "Full day values are not equal!")
        // Get the dawn value
        let dawnVal: Int = handFormulas.getDawn(myDate: Date())
        XCTAssertEqual(46025, dawnVal, "Dawn values are not equal!")
        // Testing the "convert to timezone" function
        let timeInterval: TimeInterval = handFormulas.convertToTimezone(time: 1000)
        XCTAssertEqual(-27800.0, timeInterval,
                       "The time intervals for converting to timezone are not equal!")
    }
    
    /**
     Testing the `LunarViewController` class
     */
    func testLunarViewController()
    {
        // Function to put a "0" in front of a "single-digit string"
        let makeDate: String = lunarViewController
                                    .makeDateValuesTwoDigits(dateValue: "1")
        XCTAssertEqual(makeDate, "01", "Mutable date strings are not the same!")
        // Create a test date to XCTest
        // Specify date components
        var dateComponents = DateComponents()
        dateComponents.year = 2018
        dateComponents.month = 3
        dateComponents.day = 26
        // Time zone specified by caller
        dateComponents.timeZone = TimeZone(abbreviation: "GMT")
        dateComponents.hour = 12
        dateComponents.minute = 0
        dateComponents.second = 0
        // Create date from components
        let createdDate: Date = Calendar.current.date(from: dateComponents)!
        // Function to see if the dates are equal
        let testDate: Date = lunarViewController
                                    .getDate(year: 2018, month: 3, day: 26,
                                             zone: "GMT", hour: 12, minute: 0, second: 0)
        XCTAssertEqual(createdDate, testDate,
                       "The two seperately constructed test dates are not equal!")
    }
    
    /**
     Testing the `MenuInfoViewController` class
     */
    func testMenuInfoViewController()
    {
        // Create a UI button to test setting the font color
        let textView: UITextView = UITextView()
        menuInfoViewController.setFontColor(textView: textView, backgroundType: "morningGoldenHour.jpg")
        XCTAssertEqual(UIColor.black, textView.textColor, "Colors do not match!")
    }
    
    /**
     Testing the `MenuViewController` class
     */
    func testMenuViewController()
    {
        // Create a UI button to test setting the font color
        let button: UIButton = UIButton()
        menuViewController.setFontColor(button: button, backgroundType: "evening.jpg")
        XCTAssertEqual(UIColor.orange, button.currentTitleColor, "Colors do not match!")
    }
    
    /**
     Testing the `PlanetsPopUpViewController` class
     */
    func testPlanetsPopUpViewController()
    {
        // Testing the speed switch statement
        let speed: Double = planetsPopUpViewController.determineSpeed(mult: 0.03125)
        XCTAssertEqual(32.0, speed, "Speed values are not equal!")
    }
    
    /**
     Testing the `SettingsViewController` class
     */
    func testSettingsViewController()
    {
        // Create a UI button to test setting the font color
        let label: UILabel = UILabel()
        settingsViewController.setLabelColor(label: label, backgroundType: "sunset.jpg")
        XCTAssertEqual(UIColor.orange, label.textColor, "Colors do not match!")
    }

    /**
     
     */
    func testStatsViewController()
    {
        
    }

    /**
     
     */
    func testTransferSettings()
    {
        
    }
    
    /**
     
     */
    func testWadokeiInfoViewController()
    {
        
    }

    /**
     
     */
    func testWelcomeViewController()
    {
        
    }
}
