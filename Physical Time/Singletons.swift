/**
 - Author:
 Cristian Gonzales
 
 Created for Physical Time, 2018
 */

import Foundation
import CoreLocation

/**
 A basic, bare-bones struct to keep all Singleton variables in one place.
 */
struct Singletons
{
    // The static variable shared across `PlanetViewController` and
    // `PlanetsPopUpViewController`
    static var pickerSelection = "Mercury"
    static var multiplier = 1.0
    // The global CLLocation object
    static var locationManager: CLLocationManager!
    static var currentLocation: CLLocation!
    static var coords: CLLocationCoordinate2D!
    // Configuration string for the case that the user wishes to share
    // configurable settings
    static var configString = "24:60:2:1:0.0:0:1"
    // Enumuration values for the `forKey` values
    static let hoursPerDay = "hoursPerDay"
    static let hourRevsPerDay = "hourRevsPerDay"
    static let minsPerHour = "minsPerHour"
    static let minRevsPerHour = "minRevsPerHour"
    static let FaceOffset = "faceOffset"
    static let TimeOffset = "timeOffset"
    static let mode = "mode"
    // Singletons to identify "dawn/noon" mode in the main clockface
    static let NOON_MODE = 1
    static let DAWN_MODE = 2
}
