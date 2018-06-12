/**
 - Author:
 Cristian Gonzales
 
 Created for Physical Time, 2018
 */

import XCTest
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
        XCTAssertEqual(backgroundName, "white.png", "Background name does not match up!")
    }
    
    /**
     
     */
    func testFeatureViewController()
    {
        
    }
    
    /**
     
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
