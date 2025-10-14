import SwiftUI
import Combine

@MainActor
class UserViewModel: ObservableObject {
    @Published var lifts: [Lift] = [
        Lift(name: "Push", date: Date.from(year: 2025, month: 6, day: 2), numberSets: 15, muscles: [.chest, .biceps, .triceps], numberPRs: 2),
        Lift(name: "Pull", date: Date.from(year: 2025, month: 6, day: 3), numberSets: 12, muscles: [.biceps, .shoulders], numberPRs: 1),
        Lift(name: "Legs", date: Date.from(year: 2025, month: 6, day: 4), numberSets: 18, muscles: [.chest, .biceps, .triceps], numberPRs: 3)
    ]
    
    @Published var cardios: [Cardio] = [
        Cardio(name: "Elliptical", date: Date.from(year: 2025, month: 8, day: 20), minutes: 30, calories: 250, maxHeartRate: 140),
        Cardio(name: "Seated Bike", date: Date.from(year: 2025, month: 8, day: 19), minutes: 45, calories: 400, maxHeartRate: 160),
    ]
    

    @Published var showingSheet = false
    
    @Published var inputName = ""
    @Published var inputSets = ""
    @Published var inputPRs = ""
    @Published var inputDate = Date()
    
    func addWorkout() {
        let newLift = Lift(
            name: inputName,
            date: inputDate,
            numberSets: Int(inputSets) ?? 0,
            muscles: [],
            numberPRs: Int(inputPRs) ?? 0
        )
        lifts.append(newLift)
        resetInputs()
    }
    
    func resetInputs() {
        inputName = ""
        inputSets = ""
        inputPRs = ""
        inputDate = Date()
    }
    
    func sortWorkouts<T: Workout>(_ workouts: [T], ascending: Bool = true) -> [T] {
        workouts.sorted { ascending ? $0.date < $1.date : $0.date > $1.date }
    }
}
