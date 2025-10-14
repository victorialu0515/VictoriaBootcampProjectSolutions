//
//  Workout.swift
//  WorkoutLogSolutions
//
//  Created by Victoria Lu on 2025-10-13.
//

import Foundation

enum Muscle {
    case chest, triceps, biceps, shoulders
}

protocol Workout: Identifiable {
//    var id: UUID = UUID()
//
//    var name: String
//    var date: String
//    var numberSets: Int
//    var muscles: [Muscle]
//    var numberPRs: Int
    
    var id: UUID { get }
    var name: String { get set }
    var date: Date { get set }
    
}

struct Lift: Workout {
    var id: UUID = UUID()

    var name: String
    var date: Date
    var numberSets: Int
    var muscles: [Muscle]
    var numberPRs: Int

}

struct Cardio: Workout {
    var id: UUID = UUID()

    var name: String
    var date: Date
    var minutes: Int
    var calories: Int
    var maxHeartRate: Int
}

extension Date {
    
    func formattedMonth() -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM" // e.g., "Oct"
            return formatter.string(from: self)
        }
    
    func formattedDay() -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "d" // e.g., "Oct"
            return formatter.string(from: self)
        }
    
    static func from(year: Int, month: Int, day: Int) -> Date {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        return Calendar.current.date(from: components) ?? Date()
    }
}

extension Array where Element: Workout {
    func sortedByDate(ascending: Bool = true) -> [Element] {
        self.sorted { ascending ? $0.date < $1.date : $0.date > $1.date }
    }
}
