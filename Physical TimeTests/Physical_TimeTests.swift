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
    var planetsViewController: PlanetsViewController!
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
        planetsViewController = PlanetsViewController()
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
        planetsViewController = nil
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
        
    }
    
    /**
     
     */
    func testLunarViewController()
    {
        
    }
    
    /**
     
     */
    func testMenuInfoViewController()
    {
        
    }
    
    /**
     
     */
    func testMenuViewController()
    {
        
    }
    
    /**
     
     */
    func testPlanetsPopUpViewController()
    {
        
    }

    /**
     
     */
    func testPlanetsViewController()
    {
        
    }
    
    /**
     
     */
    func testSettingsClipboardViewController()
    {
        
    }
    
    /**
     
     */
    func testSettingsViewController()
    {
        
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
