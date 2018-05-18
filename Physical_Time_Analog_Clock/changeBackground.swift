//
//  changeBackground.swift
//  Physical_Time_Analog_Clock
//
//  Created by Xi Stephen Ouyang on 5/4/18.
//  Copyright © 2018 Xi Stephen Ouyang. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

class changeBackground{
    
    func getBackground()->String{
        var coords = CLLocationCoordinate2D.init(latitude: 51.5, longitude: -0.127)
        let solar = Solar.init(coordinate: coords )
        let sunrise = solar!.sunrise!
        let sunset = solar!.sunset!
        let sunriseInterval = sunrise.timeIntervalSince1970
        let sunsetInterval = sunset.timeIntervalSince1970
        let daytime = sunsetInterval - sunriseInterval
        let date = Date()
        var timeInterval = date.timeIntervalSince1970 - 25200
        //timeInterval = sunsetInterval + 3660
        
        if (timeInterval < sunriseInterval){
            return "lunar_pic.jpg"
        } else if (timeInterval > sunriseInterval && timeInterval < (sunriseInterval + 3600)){
            return "sunrise.jpg"
        }else if(timeInterval > sunriseInterval + 3600 && timeInterval < (sunriseInterval + daytime/2)){
            return "morningGoldenHour.jpeg"
        } else if(timeInterval > (sunriseInterval + daytime/2) && timeInterval < (sunsetInterval - daytime/4)){
            return "noon.jpg"
        } else if(timeInterval > (sunsetInterval - daytime/4) && timeInterval < sunsetInterval){
            return "evening.jpg"
        }else if(timeInterval > sunsetInterval && timeInterval < (sunsetInterval + 3600)){
            return "sunset.jpg"
        }else if (timeInterval > (sunsetInterval + 3600)){
            return "lunar_pic.jpg"
        }
        
        return "morningGoldenHour.jpeg"
    }
}

