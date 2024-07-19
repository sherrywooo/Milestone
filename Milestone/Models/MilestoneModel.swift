import Foundation
import SwiftUI

//immutable struct 仅结构化，一般不包含实例化的代码
struct MilestoneModel: Identifiable,Comparable {
    var id: UUID
    var title: String
    var targetDate: Date
    var displayFormat: String
    var backgroundColor: Color
    
    static func < (lhs: MilestoneModel, rhs: MilestoneModel) -> Bool {
        lhs.targetDate < rhs.targetDate
    }

    var timeUntil: (String, String) {
        var currentDate = Date()
        var calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day], from: currentDate, to: targetDate)

        var untilSince: String
        var timeCount: String

        if currentDate < targetDate {
            untilSince = "until"
        } else {
            untilSince = "since"
        }

        var years = abs(components.year ?? 0)
        var months = abs(components.month ?? 0)
        var days = abs(components.day ?? 0)
        
        //let formatOptions = ["Years-Months-Days", "Years-Months", "Months-Days", "Days"]

        switch displayFormat {
        case "Years-Months-Days":
            timeCount = "\(years) years, \(months) months, \(days) days"
        case "Years-Months":
            timeCount = "\(years) years, \(months) months"
        case "Months-Days":
            timeCount = "\(months) months, \(days) days"
        case "Days":
            var totalDays = years * 365 + months * 30 + days
            timeCount = "\(totalDays) days"
        default:
            timeCount = "\(days) days"
        }

        return (untilSince, timeCount)
    }
    
    // 自定义初始化方法
    init(
        //形式参数，方法或函数定义时在括号中声明的参数，用于接收调用时传递的具体值。例如title
        //实际参数（实参）：方法或函数调用时传递的具体值。这些值会被传递给相应的形参。例如，调用 MilestoneModel(title: "Launch Product") 时，"Launch Product"是实际参数。
        title: String,
        targetDate: Date,
        displayFormat: String? = nil,
        backgroundColor: Color
    ) {
        self.id = UUID()
        self.title = title
        self.targetDate = targetDate
        self.displayFormat = displayFormat ?? "yyyy-MM-dd"
        self.backgroundColor = backgroundColor
    }
}
