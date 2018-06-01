/**
 - Author:
 Cristian Gonzales
 
 Created for Physical Time, 2018
 */

import Foundation
import UIKit

/**
 Fileprivate extenstion to perform fading in and fading out of elements in the
 view. See https://stackoverflow.com/a/46459103
 */
public extension UIView
{
    /**
     Fading in of a given UIView component
     - parameters:
     - duration: The duration of the fade (takes TimeInterval arg)
     - delay: The time offset of the fade (takes TimeInterval arg)
     - completion: Callback to perform code after the completion of the fade
     
     - returns:
     nil
     */
    func fadeIn(duration: TimeInterval, delay: TimeInterval, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in})
    {
        UIView.animate(withDuration: duration, delay: delay, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0
        }, completion: completion)
    }
    
    /**
     Fading out of a given UIView component
     - parameters:
     - duration: The duration of the fade (takes TimeInterval arg)
     - delay: The time offset of the fade (takes TimeInterval arg)
     - completion: Callback to perform code after the completion of the fade
     
     - returns:
     nil
     */
    func fadeOut(duration: TimeInterval, delay: TimeInterval, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in})
    {
        UIView.animate(withDuration: duration, delay: delay, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.alpha = 0.0
        }, completion: completion)
    }
}
