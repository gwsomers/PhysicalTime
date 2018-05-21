//
//  InOut.swift
//  Physical_Time_Analog_Clock
//
//  Created by ercolau on 5/6/18.
//  Copyright © 2018 Xi Stephen Ouyang. All rights reserved.
//
import Foundation
func exportSettings(fileName : String, hour : Int, minute : Int , rev : Int , mrph : Int , angle : Float , timeoff : Int , mode : Int) {
    //For exporting
     let file = fileName
     let recievedinfo = hour + ":" + minute + ":" + rev + ":" + mrph + ":" + angle + ":" + timeoff + ":" + mode
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
    //userdefaults will be used may use this for exporting
     let file = fileName
     var recievedinfo=""
     if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first{
     let fileURL = dir.appendingPathComponent(file)
     do {
     recievedinfo = try String(contentsOf: fileURL,encoding: .utf8)
        return recievedinfo
     }
     catch{
        print("File Does not exist")
     }
}
}
