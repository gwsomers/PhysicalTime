/**
 - Author:
 Xi Stephen Ouyang
 
 Created for Physical Time, 2018
 */

/**
 TODO: Add docstrings and refactor for readability/code cleanliness, and decouple
 dependencies (e.g. `object`)
 */

import Foundation

import UIKit

let object = ViewController()

/**
 helper function to convert degrees into radians
 
 - returns: CGFloat radians
 */
func degree2radian(_ deg:CGFloat) -> CGFloat
{
    let radValue = CGFloat(Double.pi) * deg / 180
    return radValue
}
/**
 helper functions that gets inputted number of partititons and splits the circle into equal partitions
 
 -returns:
 points: that are equally partition in a cirlce
 */
func circleCircumferencePoints(sides:Int, x:CGFloat,y:CGFloat, radius:CGFloat, adjustment:CGFloat=0)->[CGPoint] {
    let angle = degree2radian(360/CGFloat(sides))
    let cx = x // x origin
    let cy = y // y origin
    let r  = radius // radius of circle
    var i = sides
    var points = [CGPoint]()
    while points.count <= sides {
        let xpo = cx - r * cos(angle * CGFloat(i)+degree2radian(adjustment))
        let ypo = cy - r * sin(angle * CGFloat(i)+degree2radian(adjustment))
        points.append(CGPoint(x: xpo, y: ypo))
        i -= 1
    }
    return points
}
/**
 helper function that draws a marker at each point given differentiating between a second marker and an hour marker
 - returns: nil
 */
func secondMarkers(ctx:CGContext, x:CGFloat, y:CGFloat, radius:CGFloat, sides:Int, color:UIColor) {
    // retrieve points
    let points = circleCircumferencePoints(sides:sides,x:x,y:y,radius:radius)
    // create path
    let path = CGMutablePath()
    // determine length of marker as a fraction of the total radius
    var divider:CGFloat = 1/16
    for p in points.enumerated() {
        if p.offset % object.getModulus() == 0 {
            divider = 1/8
        }
        else {
            divider = 1/16
        }
        
        let xn = p.element.x + divider*(x-p.element.x)
        let yn = p.element.y + divider*(y-p.element.y)
        // build path
        path.move(to: CGPoint(x: p.element.x, y: p.element.y))
        path.addLine(to: CGPoint(x: xn, y: yn))
        path.closeSubpath()
        path.closeSubpath()
        // add path to context
        ctx.addPath(path)
    }
    // set path color
    let cgcolor = color.cgColor
    ctx.setStrokeColor(cgcolor)
    ctx.setLineWidth(3.0)
    ctx.strokePath()
    
}

/**
 Class representing the UIView subclass that draws the augmented clock ViewController
 */
class View: UIView
{
    override func draw(_ rect:CGRect)
    {
        // Obtain context
        let ctx = UIGraphicsGetCurrentContext()
        
        // Decide on radius
        let rad = rect.width/2.5
        
        let endAngle = CGFloat(2 * Double.pi)
        
        // add the circle to the context
        ctx?.addArc(center: CGPoint(x:rect.midX, y:rect.midY), radius: rad, startAngle: 0, endAngle: endAngle, clockwise: true)
        
        // set fill color
        ctx?.setFillColor(UIColor.blue.cgColor)
        
        // set stroke color
        ctx?.setStrokeColor(UIColor.black.cgColor)
        
        // set line width
        ctx?.setLineWidth(4.0)
        
        // draw the path
        ctx?.drawPath(using: .fillStroke)
        
        // uses helper function secondMarkers to draw the markers given amount of hours and minutes in a day
        secondMarkers(ctx: ctx!, x: rect.midX, y: rect.midY, radius: rad, sides: object.getClockSide(), color: UIColor.black)
    }
}
