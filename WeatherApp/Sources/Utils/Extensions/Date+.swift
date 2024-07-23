//
//  Date+.swift
//  WeatherApp
//
//  Created by 이원빈 on 2024/07/23.
//

import Foundation

extension Date {
    
    static func fromTimestamp(_ timestamp: TimeInterval) -> Date {
        return Date(timeIntervalSince1970: timestamp)
    }
    
    func toKoreaTimeString(format: String = "yyyy-MM-dd HH:mm:ss") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        dateFormatter.locale = Locale(identifier: "ko_KR")
        return dateFormatter.string(from: self)
    }
    
    func isSameDay(as otherDate: Date) -> Bool {
        let calendar = Calendar.current
        let components1 = calendar.dateComponents([.year, .month, .day], from: self)
        let components2 = calendar.dateComponents([.year, .month, .day], from: otherDate)
        
        return components1.year == components2.year &&
               components1.month == components2.month &&
               components1.day == components2.day
    }
}
