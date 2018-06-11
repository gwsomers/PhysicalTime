/**
 - Author:
 Erik Lau
 
 Created for Physical Time, 2018
 */

import Foundation

/**
 The class that instantiates helper functions to "transfer" (e.g. import or export)
 settings. Export will write to a file with the defined relative path of a file, and
 import will return a mutable string
 */
class TransferSettings
{
    /**
     Helper function instantiated by the caller to export settings, or write the
     settings that the user has input to a file
     
     - parameters:
     - fileName: The relative path of the filename on a user's device
     - hour: The amount of hours in a day, as parsed and passed in by the caller
     - minute: The amount of minutes in a day, as parsed and passed in by the caller
     - rev: The hour revolutions for the day, as parsed and passed in by the caller
     - mrph: The amount of minute revolutions per hour, as parsed and passed in by the caller
     - angle: TODO
     - timeoff: The revolutions for the day, as parsed and passed in by the caller
     - mode: If we are in "dawn" mode, as parsed and passed in by the caller
     */
    func exportSettings(fileName: String, hour: Int, minute: Int,
                        rev: Int, mrph: Int, angle: Float, timeoff: Int, mode: Int) -> Void
    {
        let recievedinfo = String(hour) + ":" + String(minute) + ":" + String(rev) + ":" + String(mrph) + ":" + String(angle) + ":" + String(timeoff) + ":" + String(mode)
        if let dir = FileManager.default.urls(for: .documentDirectory,
                                               in: .userDomainMask).first
        {
            let fileURL = dir.appendingPathComponent(fileName)
            do
            {
                try recievedinfo.write(to: fileURL, atomically: true,
                                       encoding: String.Encoding.utf8)
            }
            catch
            {
                // TODO
            }
        }
    }

    /**
     Helper function to import settings onto the clock, as defined by a file on a user's
     phone
     
     - parameters:
     - fileName: The name of the file name, or the relative path on the user's phone
     
     - returns:
     A mutable string with the user's "settings"
     */
    func importSettings(fileName: String) -> String
    {
        if let dir = FileManager.default.urls(for: .documentDirectory,
                                              in: .userDomainMask).first
        {
            let fileURL = dir.appendingPathComponent(fileName)
            do
            {
                return try String(contentsOf: fileURL, encoding: .utf8)
            }
            catch
            {

            }
        }
        return "24:60:2:1:0.0:0:1"
    }
}
