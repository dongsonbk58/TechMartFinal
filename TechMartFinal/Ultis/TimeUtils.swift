//
//  TimeConstant.swift
//  FAC_IOS
//
//  Created by nguyen.dong.son on 5/22/18.
//  Copyright © 2018 DaoLQ. All rights reserved.
//

import Foundation

struct TimeUtils {
    static func getPaydayCountDown(today: String, payday: String) -> Int {
        let formatter  = DateFormatter()
        let calendar = Calendar.current
        formatter.dateFormat = "yyyy-MM-dd"
        guard let todayDate = formatter.date(from: today), let paydayDate = formatter.date(from: payday) else { return 0 }
        let todayComponent = calendar.component(.day, from: todayDate)
        let paydayComponent = calendar.component(.day, from: paydayDate)
        return (paydayComponent - todayComponent) > 0 ? paydayComponent - todayComponent : todayComponent - paydayComponent
    }

    static func convertDay(day: String) -> String {
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let notificationDay = formatter.date(from: day)else { return "" }
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: notificationDay)
    }

    static func getYearCurrent() -> Int {
        let dateCurrent = Date()
        let calenderCurrent = Calendar.current
        let componentsCurrent = calenderCurrent.dateComponents([.year, .month], from: dateCurrent)
        guard let tmpYearCurrent = componentsCurrent.year else {
            return 1970
        }
        return tmpYearCurrent
    }
}
