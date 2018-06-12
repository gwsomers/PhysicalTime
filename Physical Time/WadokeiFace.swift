/**
 - Author:
 Khai Hua
 
 Created for Physical Time, 2018
 */

import Foundation
import UIKit
import CoreLocation

/**
 Class representing the UIView subclass that draws the wadokei clock face on WadokeiViewController
 */
class WadokeiView: UIView
{
    /**
     Overrides function draw, this is called when creating a new subview in WadokeiViewController and is
     responsible for drawing the different slices in a Wadokei Clock
     
     - returns:
     nil
     */
    override func draw(_ rect:CGRect)
    {
        let ctx = UIGraphicsGetCurrentContext()
        //amount of suntime and nighttime in a day using helper functions getSunset getSunrise and subtracting it to get amount of suntime
        var suntime = (getSunset() - getSunrise())
        //nighttime is acquired from subtracting suntime from 86400 which is equivalent to one whole day
        var nighttime = 86400 - suntime
        // suntime and nighttime is then turned into a percentage of a day
        suntime = suntime / 86400 * 100
        nighttime = nighttime / 86400 * 100
        //offset is used to see whether there is more suntime or nighttime and offsets the slice drawn accordingly
        var offset = CGFloat(suntime - nighttime)
        //divide each percentage by 6 to get 6 total slices and amount to offset by
        offset = offset / 4
        suntime = suntime / 6
        nighttime = nighttime / 6
        
        //uses helper function drawSlice to draw the 12 different slices
        drawSlice(rect: rect, startPercent: 0 - offset, endPercent: CGFloat(suntime) - offset , color: UIColor.orange)
        drawSlice(rect: rect, startPercent: CGFloat(suntime) - offset, endPercent: (CGFloat(suntime)) * 2 - offset, color: UIColor.orange)
        drawSlice(rect: rect, startPercent: (CGFloat(suntime) * 2) - offset, endPercent: (CGFloat(suntime) * 3) - offset, color: UIColor.orange)
        drawSlice(rect: rect, startPercent: (CGFloat(suntime) * 3) - offset, endPercent: (CGFloat(suntime) * 4) - offset, color: UIColor.orange)
        drawSlice(rect: rect, startPercent: (CGFloat(suntime) * 4) - offset, endPercent: (CGFloat(suntime) * 5) - offset, color: UIColor.orange)
        drawSlice(rect: rect, startPercent: (CGFloat(suntime) * 5) - offset, endPercent: (CGFloat(suntime) * 6) - offset, color: UIColor.orange)
        drawSlice(rect: rect, startPercent: (CGFloat(suntime) * 6) - offset, endPercent: (CGFloat(suntime) * 6) + CGFloat(nighttime) - offset, color: UIColor.blue)
        drawSlice(rect: rect, startPercent: (CGFloat(suntime) * 6) + CGFloat(nighttime) - offset, endPercent: (CGFloat(suntime) * 6) + (CGFloat(nighttime) * 2) - offset, color: UIColor.blue)
        drawSlice(rect: rect, startPercent: (CGFloat(suntime) * 6) + (CGFloat(nighttime) * 2) - offset, endPercent: (CGFloat(suntime) * 6) + (CGFloat(nighttime) * 3) - offset, color: UIColor.blue)
        drawSlice(rect: rect, startPercent: (CGFloat(suntime) * 6) + (CGFloat(nighttime) * 3) - offset, endPercent: (CGFloat(suntime) * 6) + (CGFloat(nighttime) * 4) - offset, color: UIColor.blue)
        drawSlice(rect: rect, startPercent: (CGFloat(suntime) * 6) + (CGFloat(nighttime) * 4) - offset, endPercent: (CGFloat(suntime) * 6) + (CGFloat(nighttime) * 5) - offset, color: UIColor.blue)
        drawSlice(rect: rect, startPercent: (CGFloat(suntime) * 6) + (CGFloat(nighttime) * 5) - offset, endPercent: (CGFloat(suntime) * 6) + (CGFloat(nighttime) * 6) - offset, color: UIColor.blue)
       
        
        let rad = min(rect.width, rect.height) / 2.5
        // uses helper function drawText to drar text 1 - 24 across 24 equally partitioned points on the circle
        drawText(rect:rect, ctx: ctx!, x: rect.midX, y: rect.midY, radius: rad, sides: .twentyfour, color: UIColor.white)
    }
    
    /**
     This is the helper function that draws the different slices depending on the start percentage and end percentage
     
     - returns:
     nil
     */
    private func drawSlice(rect: CGRect, startPercent: CGFloat,
                           endPercent: CGFloat, color: UIColor)
    {
        //methods to draw a semicircle, partitions a circle from 0 to 100 percent
        let radius = min(rect.width, rect.height) / 2.5
        //Get starting drawing angle at a given percentage
        let startAngle = startPercent / 100 * CGFloat(Double.pi) * 2 - CGFloat(Double.pi)
        //Get ending drawing angle at given percentage
        let endAngle = endPercent / 100 * CGFloat(Double.pi) * 2 - CGFloat(Double.pi)
        let path = UIBezierPath()
        path.move(to: center)
        //draws the semicircle given the start angle and end angle
        path.addArc(withCenter: CGPoint(x:rect.midX, y:rect.midY), radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        path.close()
        UIColor.white.setStroke()
        path.stroke()
        color.setFill()
        path.fill()
    }
    
    enum NumberOfNumerals: Int
    {
        case two = 2, four = 4, twelve = 12, twentyfour = 24
    }
    
    
    /**
     This is the helper function to draw the 24 different numbers across an equally portioned 24 points in a circle
    
     - returns:
     nil
     */
    func drawText(rect:CGRect, ctx:CGContext, x:CGFloat,
                  y:CGFloat, radius:CGFloat, sides:NumberOfNumerals,
                  color:UIColor)
    {
        ctx.translateBy(x: 0.0, y: rect.height)
        ctx.scaleBy(x: 1.0, y: -1.0)
        let inset:CGFloat = radius/8
        let points = circleCircumferencePoints(sides: sides.rawValue,x: x,y: y,radius: radius-inset,adjustment:90)
        let multiplier = 24/sides.rawValue
        // finds 24 equally portioned segments in the circle and draws the number text in each point
        for p in points.enumerated() {
            if p.offset > 0 {
                let aFont = UIFont(name: "Times New Roman", size: radius/6)
                let attr:CFDictionary = [NSAttributedStringKey.font:aFont!,NSAttributedStringKey.foregroundColor:UIColor.white] as CFDictionary
                let str = String(p.offset*multiplier)
                let text = CFAttributedStringCreate(nil, str as CFString?, attr)
                let line = CTLineCreateWithAttributedString(text!)
                let bounds = CTLineGetBoundsWithOptions(line, CTLineBoundsOptions.useOpticalBounds)
                ctx.setLineWidth(1.5)
                ctx.setTextDrawingMode(.stroke)
                let xn = p.element.x - bounds.width/2
                let yn = p.element.y - bounds.midY
                ctx.textPosition = CGPoint(x: xn, y: yn)
                CTLineDraw(line, ctx)
            }
        }
    }
    
    /**
     helper function to convert degrees into radians
     
     - returns: CGFloat radians
     */
    func degree2radians(_ a:CGFloat)->CGFloat
    {
        
        let b = CGFloat(Double.pi) * a/180
        
        return b
        
    }
    
    /**
     helper function that calls Solar.swift to get the current date's sunrise time
     
     -returns :Double sunrise time
     */
    func getSunrise()->Double
    {
        //initialzie the coordinates
        let coords = CLLocationCoordinate2D.init(
                        latitude: Singletons.coords.latitude,
                        longitude: Singletons.coords.longitude)
        // use Solar.swift to get sunrise time
        let solar = Solar.init(coordinate: coords)
        let sunrise = solar!.sunrise!
        return sunrise.timeIntervalSince1970
        
    }
    
    /**
     helper function that calls Solar.swift to get the current date's sunrise time
     
     -returns :Double sunset time
     */
    func getSunset()->Double
    {
        //initialize the coordinates
        let coords = CLLocationCoordinate2D.init(
                        latitude: Singletons.coords.latitude,
                        longitude: Singletons.coords.longitude)
        //use Solar.swift to get sunset tine
        let solar = Solar.init(coordinate: coords)
        let sunset = solar!.sunset!
        return sunset.timeIntervalSince1970
    }
}
