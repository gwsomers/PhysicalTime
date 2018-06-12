/**
 - Author:
 Cristian Gonzales, Khai Hua
 
 Created for Physical Time, 2018
 */

import Foundation
import UIKit
import CoreLocation

/**
 Class that acts as a subview for serving as an "copy to clipboard page" to the
 Settings parent view controller
 */
class SettingsClipboardViewController: UIViewController
{
    // All UI elements to be configured on load
    @IBOutlet weak var configStringField: UITextField!
    @IBOutlet weak var copiedPopupImage: UIImageView!
    
    /**
     On the load, make the background color the "fade" effect, where the
     parent ViewController can still be seen. Also, the `showAnimate()`
     function is instantiated (see docstrings)
     */
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        self.showAnimate()
        configStringField.text = Singletons.configString
    }
    
    /**
     When the user taps on the popup, the white window will close
     
     - returns:
     Void
     */
    @IBAction func closePopup(_ sender: UITapGestureRecognizer)
    {
        self.removeAnimate()
    }
    
    /**
     When the user clicks the button,
     
     - returns:
     Void
     */
    @IBAction func copyPressed(_ sender: UIButton)
    {
        // Initialize the pasting to the device's clipboard
        UIPasteboard.general.string = Singletons.configString
        // Make the pop-up appear sporadically
        copiedPopupImage.alpha = 1
    }
    /**
     Helper function to animate this view by changing its
     alpha and transform values.
     
     - returns:
     Void
     */
    func showAnimate() -> Void
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
    }
    
    /**
     Helper function to animate this view by changing its
     alpha and transform values. At the end, it removes itself
     from the parent view controller, `WadokeiViewController`
     
     - returns:
     Void
     */
    func removeAnimate() -> Void
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0
        }, completion: {(finished: Bool) in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        })
    }
}
