import Foundation
import UIKit

class ExpenseTypeTheme {
    var color: UIColor?
    var image: UIImage?
    
    func themeFor(type:String, with opacity:CGFloat) -> ExpenseTypeTheme {
        switch type {
        case "Groceries":
            self.color = UIColor.red.withAlphaComponent(opacity)
            self.image = UIImage(named: "ic_shopping_cart_white")
            return self
        case "Food and Beverage":
            self.color = UIColor.green.withAlphaComponent(opacity)
            self.image = UIImage(named: "ic_cake_white")
            return self
        case "Miscellaneous":
            self.color = UIColor.blue.withAlphaComponent(opacity)
            self.image = UIImage(named: "ic_build_white")
            return self
        case "Health and Fitness":
            self.color = UIColor.cyan.withAlphaComponent(opacity)
            self.image = UIImage(named: "ic_fitness_center_white")
            return self
        case "Clothing":
            self.color = UIColor.brown.withAlphaComponent(opacity)
            self.image = UIImage(named: "ic_accessibility_white")
            return self
        case "Entertainment":
            self.color = UIColor.purple.withAlphaComponent(opacity)
            self.image = UIImage(named: "ic_music_note_white")
            return self
        case "Household":
            self.color = UIColor.yellow.withAlphaComponent(opacity)
            self.image = UIImage(named: "ic_build_white")
            return self
        case "Medical":
            self.color = UIColor.orange.withAlphaComponent(opacity)
            self.image = UIImage(named: "ic_healing_white")
            return self
        case "Travel":
            self.color = UIColor.magenta.withAlphaComponent(opacity)
            self.image = UIImage(named: "ic_airplanemode_active_white")
            return self
        default:
            self.color = UIColor.gray.withAlphaComponent(opacity)
            self.image = UIImage(named: "ic_build_white")
            return self
        }
    }
    
}
