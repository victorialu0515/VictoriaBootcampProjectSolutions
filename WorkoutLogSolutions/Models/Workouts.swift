//
//  Workouts.swift
//  WorkoutLog
//
//  Created by Alec Hance on 8/9/25.
//
import SwiftUI


enum Muscle {
    case chest, triceps, biceps, shoulders
}



protocol Workout: Identifiable {
    var id: UUID { get }
    var name: String { get }
    var date: Date { get }
    var topSummary: String { get }
    var midSummary: String { get }
    var botSummary: String { get }
}


struct Lift: Identifiable, Workout {
    var id: UUID = UUID()
    
    var name: String
    var date: Date
    var numberSets: Int
    var muscles: [Muscle]
    var numberPRs: Int
    
    var topSummary: String {
        "\(numberSets) Total Sets"
    }
    
    var midSummary: String {
        "\(muscles.count) Muscles Hit"
    }
    
    var botSummary: String {
        "\(numberPRs) PRs"
    }
}

struct Cardio: Identifiable, Workout {
    var id: UUID = UUID()
    
    var name: String
    var date: Date
    var minutes: Int
    var calories: Int
    var maxHR: Int
    
    var topSummary: String {
        "\(minutes) Minutes Completed"
    }
    
    var midSummary: String {
        "\(calories) Calories Burned"
    }
    
    var botSummary: String {
        "\(maxHR) BPM Max Heart Rate"
    }
}
