
import Foundation
import UIKit

class Colors {
    
    static func colorFor(_ type: String, opacity:CGFloat) -> UIColor {
        switch type {
        case "Groceries":
            return UIColor.red.withAlphaComponent(opacity)
        case "Restaurant":
            return UIColor.green.withAlphaComponent(opacity)
        case "Miscellaneous":
            return UIColor.blue.withAlphaComponent(opacity)
        case "Health and Fitness":
            return UIColor.cyan.withAlphaComponent(opacity)
        case "Clothing":
            return UIColor.brown.withAlphaComponent(opacity)
        case "Entertainment":
            return UIColor.purple.withAlphaComponent(opacity)
        case "Household Supplies":
            return UIColor.yellow.withAlphaComponent(opacity)
        default:
            return UIColor.gray.withAlphaComponent(opacity)
        }
    }
    
    static let foreground = UIColor(red: 100/255, green: 220/255, blue: 100/255, alpha: 1.00)
    static let foregroundBright = UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 1.00)
    static let background = UIColor(red: 60/255, green: 60/255, blue: 60/255, alpha: 1.00)
    
    
    static let cellBackground = UIColor(red: 60/255, green: 60/255, blue: 60/255, alpha: 1.00)
    static let cellBackgroundDark = UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 1.00)
    
    static let warn = UIColor(red: 255/255, green: 81/255, blue: 78/255, alpha: 1.00)
    static let success = UIColor(red: 100/255, green: 220/255, blue: 100/255, alpha: 1.00)

    
}
