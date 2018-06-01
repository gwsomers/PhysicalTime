/**
 - Author:
 Erik Lau
 
 Created for Physical Time, 2018
 */
import Foundation
func exportSettings(fileName : String, hour : Int, minute : Int , rev : Int , mrph : Int , angle : Float , timeoff : Int , mode : Int) {
    print("exporting")
    //For exporting
     let file = fileName
     let recievedinfo = String(hour) + ":" + String(minute) + ":" + String(rev) + ":" + String(mrph) + ":" + String(angle) + ":" + String(timeoff) + ":" + String(mode)
    print(recievedinfo)
     if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first{
     let fileURL = dir.appendingPathComponent(file)
     do {
     try recievedinfo.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
     }
     catch{
        
        }
     }
}
func importSettings(fileName : String) -> String{
    print("importing")
    //userdefaults will be used may use this for exporting
     let file = fileName
     var recievedinfo=""
     if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first{
     let fileURL = dir.appendingPathComponent(file)
     do {
     recievedinfo = try String(contentsOf: fileURL,encoding: .utf8)
     }
     catch{
        print("File Does not exist")
        recievedinfo = "24:60:2:1:0.0:0:1"
     }
}
    print(recievedinfo)
    return recievedinfo
}
