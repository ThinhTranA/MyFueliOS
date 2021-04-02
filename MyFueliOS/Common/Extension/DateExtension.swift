//
//  DateExtension.swift
//  MyFueliOS
//
//  Created by Thinh Tran on 2/4/21.
//

import Foundation

enum WeekDay: Int {
    case sunday = 1
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
}
extension Date {
    func getWeekDay() -> WeekDay {
        let calendar = Calendar.current
        let weekDay = calendar.component(Calendar.Component.weekday, from: self)
        return WeekDay(rawValue: weekDay)!
    }
}
