import Foundation

class Utils {
    
    static func formatDate(_ date:Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        let dateString = formatter.string(from: date)
        
        return dateString
        
    }
}

class Week {
    var startDate = Date()
    var endDate = Date()
    var expenses = [Expense]()
    
    init(offset: Int){
        let calendar = getCalendar()
        startDate = findStartDate(offset: offset, calendar)
        endDate = findEndDate(offset: offset, calendar)
    }
    
    func findStartDate(offset: Int, _ cal: Calendar) -> Date {
        var comps = cal.dateComponents([.weekOfYear, .yearForWeekOfYear], from: Date())
        comps.weekday = 2
        guard let monday = cal.date(from: comps) else { return Date() }
        
        if(offset <= 0){
            return monday
        }
        
        guard let date = cal.date(byAdding: Calendar.Component.weekOfMonth, value: -(offset), to: monday) else { return Date() }
        
        return date
    }
    
    func findEndDate(offset: Int, _ cal: Calendar) -> Date {
        if offset == 0 {
            return Date()
        }
        
        var thisWeek = getThisWeek(cal: cal)
        thisWeek.weekday = 1
        
        let sunday = cal.date(from: thisWeek)
        let sundayEndOfDay = cal.date(bySettingHour: 23, minute: 59, second: 59, of: sunday!)!
        let sundayWithNanos = cal.date(bySetting: Calendar.Component.nanosecond, value: 1000000, of: sundayEndOfDay)!
        
        return cal.date(byAdding: Calendar.Component.weekOfMonth, value: -(offset), to: sundayWithNanos)!
        
    }
    
    func getThisWeek(cal: Calendar) -> DateComponents {
        return cal.dateComponents([.month, .year, .weekOfMonth, .weekOfYear], from: Date())
    }
    
    fileprivate func getCalendar() -> Calendar {
        var cal = Calendar.current
        cal.firstWeekday = 2
        cal.timeZone = TimeZone(abbreviation: "GMT")!
        
        return cal
    }
}
