/**
 - Author:
 Cristian Gonzales
 
 Created for Physical Time, 2018
 */

import Foundation

/**
 A basic, bare-bones struct to keep all Singleton variables in one place.
 */
struct Singletons
{
    // The static variable shared across `PlanetViewController` and
    // `PlanetsPopUpViewController`
    static var pickerSelection = "Mercury"
    static var multiplier = 1.0
    // TODO
    static var latitude = 0.0
    static var longitude = 0.0
}
