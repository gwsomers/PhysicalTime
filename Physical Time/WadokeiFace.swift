/**
 - Author:
 Khai Hua
 
 Created for Physical Time, 2018
 */

import Foundation

import UIKit

import CoreLocation



func degree2radians(_ a:CGFloat)->CGFloat {
    
    let b = CGFloat(Double.pi) * a/180
    
    return b
    
}

func getSunrise()->Double{
    
    let coords = CLLocationCoordinate2D.init(latitude: 51.5, longitude: -0.127)
    
    let solar = Solar.init(coordinate: coords )
    
    let sunrise = solar!.sunrise!
    
    return sunrise.timeIntervalSince1970
    
}



func getSunset()->Double{
    
    let coords = CLLocationCoordinate2D.init(latitude: 51.5, longitude: -0.127)
    
    let solar = Solar.init(coordinate: coords )
    
    let sunset = solar!.sunset!
    
    return sunset.timeIntervalSince1970
    
    
    
}

class WadokeiView: UIView {
    
    override func draw(_ rect:CGRect)
    {
        let ctx = UIGraphicsGetCurrentContext()
        
        var suntime = (getSunset() - getSunrise())
        
        var nighttime = 86400 - suntime
        
        suntime = suntime / 86400 * 100
        
        nighttime = nighttime / 86400 * 100
        
        var offset = CGFloat(suntime - nighttime)
        
        offset = offset / 4
        
        suntime = suntime / 6
        
        nighttime = nighttime / 6
        
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
        drawText(rect:rect, ctx: ctx!, x: rect.midX, y: rect.midY, radius: rad, sides: .twentyfour, color: UIColor.white)
    }
    
    private func drawSlice(rect: CGRect, startPercent: CGFloat, endPercent: CGFloat, color: UIColor) {
        
        let radius = min(rect.width, rect.height) / 2.5
        
        let startAngle = startPercent / 100 * CGFloat(Double.pi) * 2 - CGFloat(Double.pi)
        
        let endAngle = endPercent / 100 * CGFloat(Double.pi) * 2 - CGFloat(Double.pi)
        
        let path = UIBezierPath()
        
        path.move(to: center)
        
        path.addArc(withCenter: CGPoint(x:rect.midX, y:rect.midY), radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        path.close()
        
        UIColor.white.setStroke()
        
        path.stroke()
        
        color.setFill()
        
        path.fill()
        
    }
    enum NumberOfNumerals:Int {
        case two = 2, four = 4, twelve = 12, twentyfour = 24
    }
    func drawText(rect:CGRect, ctx:CGContext, x:CGFloat, y:CGFloat, radius:CGFloat, sides:NumberOfNumerals, color:UIColor) {
        
        ctx.translateBy(x: 0.0, y: rect.height)
        ctx.scaleBy(x: 1.0, y: -1.0)
        let inset:CGFloat = radius/8
        let points = circleCircumferencePoints(sides: sides.rawValue,x: x,y: y,radius: radius-inset,adjustment:90)
        let multiplier = 24/sides.rawValue
        
        for p in points.enumerated() {
            if p.offset > 0 {
                let aFont = UIFont(name: "Times New Roman", size: radius/6)
                let attr:CFDictionary = [NSAttributedStringKey.font:aFont!,NSAttributedStringKey.foregroundColor:UIColor.white] as CFDictionary
                let str = String(p.offset*multiplier)
                let text = CFAttributedStringCreate(nil, str as CFString!, attr)
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
    
    
    
}



