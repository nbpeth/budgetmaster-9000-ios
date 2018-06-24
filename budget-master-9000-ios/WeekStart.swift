import RealmSwift
import Foundation

class WeekStart: Object {
    var startDate = RealmOptional<Int>()
    
    convenience init(_ day: Int){
        self.init()
        self.startDate.value = day
    }
}

extension WeekStart {
    static func getWeekStart() -> Int {
        let realm = try! Realm()
        return realm.objects(WeekStart.self).first?.startDate.value ?? 1
    }
    
    static func setWeekStart(day: Int) {
        let realm = try! Realm()
        if let current = realm.objects(WeekStart.self).first {
            try! realm.write {
                current.startDate.value = day
            }
        }
        else {
            try! realm.write {
                realm.add(WeekStart(day))
            }
        }
    }
}

extension Int {
    func getNameOfDay() -> String {
        print("!!!")
        print(self)
        return [1:"Sunday",2:"Monday",3:"Tuesday",4:"Wednesday",5:"Thursday",6:"Friday",7:"Saturday"][self] ?? ""
        
    }
}
