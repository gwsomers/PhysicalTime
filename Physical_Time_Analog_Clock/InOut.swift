//
//  InOut.swift
//  Physical_Time_Analog_Clock
//
//  Created by ercolau on 5/6/18.
//  Copyright © 2018 Xi Stephen Ouyang. All rights reserved.
//
import Foundation
func exportSettings(fileName:String) {
    //For exporting
     let file = fileName
     let defaultinfo = "24:60:2:0:1:0:1"
     var recievedinfo=""
     if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first{
     let fileURL = dir.appendingPathComponent(file)
     do {
     try defaultinfo.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
     }
     catch{}
     }
}
func importSettings(fileName:String) {
    //userdefaults will be used may use this for exporting
     let file = fileName
     let defaultinfo = "24:60:2:0:1:0:1"
     var recievedinfo=""
     if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first{
     let fileURL = dir.appendingPathComponent(file)
     do {
     recievedinfo = try String(contentsOf: fileURL,encoding: .utf8)
     let WordsArray = recievedinfo.components(separatedBy: ":")
     var count = 0;
     for sect in WordsArray{
     if count == 0{
     let dh: String = sect
     //defaulthour = Int(dh)!
     }
     if count == 1{
     let dh: String = sect
    // defaultminute = Int(dh)!
     }
     if count == 2{
     let dh: String = sect
    // defaultREVDAY = Int(dh)!
     }
     if count == 3{
     let dh: String = sect
  //   defaultREVHOUR = Int(dh)!
     }
     if count == 4{
     let dh: String = sect
   //  defaultANGOFF = Float(dh)!
     }
     if count == 5{
     let dh: String = sect
   //  defaultTIMEOFF = Int(dh)!
     }
     if count == 6{
     let dh: String = sect
    // defaultMODE = Int(dh)!
     }
     count = count + 1
     }
     }
     catch{
        print("File Does not exist")
     }
}
}
