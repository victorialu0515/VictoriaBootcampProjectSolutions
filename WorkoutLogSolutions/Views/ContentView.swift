//
//  ContentView.swift
//  WorkoutLog
//
//  Created by Alec Hance on 7/27/25.
// Victoria Lu

import SwiftUI

extension Date {
    func monthDayMultiline() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM\nd"
        return formatter.string(from: self)
    }
}


extension Array where Element: Workout {
    func sortedBy<Value: Comparable>(_ key: (Element) -> Value, ascending: Bool = true) -> [Element] {
        self.sorted {
            ascending ? key($0) < key($1) : key($0) > key($1)
        }
    }
}




struct LogView: View {
    @State var lifts: [Lift] = [Lift(name: "Push", date: Calendar.current.date(byAdding: .day, value: 0, to: Date()) ?? Date(), numberSets: 15, muscles: [.chest, .biceps, .triceps], numberPRs: 2), Lift(name: "Pull", date: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date(), numberSets: 15, muscles: [.chest, .biceps, .triceps], numberPRs: 2), Lift(name: "Legs", date: Calendar.current.date(byAdding: .day, value: 2, to: Date()) ?? Date(), numberSets: 15, muscles: [.chest, .biceps, .triceps], numberPRs: 2)]
    @State var cardios: [Cardio] = [Cardio(name: "Seated Bike", date: Calendar.current.date(byAdding: .day, value: -2, to: Date()) ?? Date(), minutes: 30, calories: 300, maxHR: 150), Cardio(name: "Eliptical", date: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date(), minutes: 45, calories: 400, maxHR: 140)]
    @State var showingSheet: Bool = false
    @State var inputName: String = ""
    @State var inputSets: String = ""
    @State var inputPRs: String = ""
    @State var inputDate: String = ""
    @State var showCardio: Bool = false
    @State var insertDate: Date = Date()
    @State var selectedMuscles: [Muscle] = []
    @State var showingMusclePicker = false
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                VStack {
                    topButtonHStack
                    Text("Log")
                        .font(.system(size: 35))
                        .bold()
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 10)
                    
                    belowTitleHStack.padding(.top, 4)
                    
                    Picker("", selection: $showCardio) {
                        Text("Lifts").tag(false)
                        Text("Cardio")
                            .tag(true)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .tint(.white)
                    .foregroundStyle(.red)
                    
                    ScrollView {
                        if !showCardio {
                            ForEach($lifts.sorted(by: { $0.wrappedValue.date < $1.wrappedValue.date })) { $lift in
                                NavigationLink(
                                    destination: LiftView(
                                        lift: $lift,
                                        onDelete: {
                                            if let index = lifts.firstIndex(where: { $0.id == lift.id }) {
                                                lifts.remove(at: index)
                                            }
                                        }
                                    )
                                ) {
                                    WorkoutCard(workout: lift)
                                }
                            }
                        } else {
                            ForEach(cardios.sortedBy({ $0.date }, ascending: false)) { cardio in
                                WorkoutCard(workout: cardio)
                            }
                        }
                    }
                    
                    
                }
                .padding(.horizontal, 10)
                .frame(width: geometry.size.width, height: geometry.size.height)
                .background(.black)
                .sheet(isPresented: $showingSheet) {
                    NavigationStack {
                        sheetView.background(Color(red: 0.1, green: 0.1, blue: 0.1))
                    }
                    
                }
            }
        }
    }
        
    var sheetView: some View {
        VStack(alignment: .leading) {
            Button {
                showingSheet.toggle()
            } label: {
                Image(systemName: "chevron.left")
                    .foregroundStyle(.cyan)
            }
            .padding(.bottom, 10)
            Text("Enter New Workout")
                .font(.title)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(.bottom, 40)
                .padding(.top, 30)
            ZStack {
                VStack(alignment: .leading) {
                    TextField("", text: $inputName, prompt: Text("enter name").foregroundStyle(Color(red: 0.6, green: 0.6, blue: 0.6)))
                        .foregroundStyle(.white)
                    Rectangle().frame(height: 1).foregroundStyle(Color(red: 0.6, green: 0.6, blue: 0.6))
                    TextField("", text: $inputSets, prompt: Text("number of sets").foregroundStyle(Color(red: 0.6, green: 0.6, blue: 0.6)))
                        .foregroundStyle(.white)
                    Rectangle().frame(height: 1).foregroundStyle(Color(red: 0.6, green: 0.6, blue: 0.6))
                    TextField("", text: $inputPRs, prompt: Text("number of PRs").foregroundStyle(Color(red: 0.6, green: 0.6, blue: 0.6)))
                        .foregroundStyle(.white)
                    Rectangle().frame(height: 1).foregroundStyle(Color(red: 0.6, green: 0.6, blue: 0.6))
                    
                    HStack {
                        Text("Muscles:")
                            .foregroundStyle(Color(red: 0.6, green: 0.6, blue: 0.6))
                            .padding(.trailing, 5)
                        
                        NavigationLink(destination: MuscleSelectionView(selectedMuscles: $selectedMuscles)) {
                            Text("Select Muscles")
                                .foregroundStyle(.white)
                                .padding(5)
                                .background(Color(red: 0.15, green: 0.15, blue: 0.15))
                                .cornerRadius(10)
                        }
                        .buttonStyle(.plain)

                    }
                    
                    Rectangle().frame(height: 1).foregroundStyle(Color(red: 0.6, green: 0.6, blue: 0.6))
                    HStack {
                        DatePicker(
                            "Start Date:",
                            selection: $insertDate,
                            displayedComponents: [.date]
                        ).foregroundStyle(Color(red: 0.6, green: 0.6, blue: 0.6))
                            .colorScheme(.dark)
                            
                    }.frame(width: UIScreen.main.bounds.width * 0.55)
    
                }
                .frame(maxHeight: .infinity, alignment: .top)
                .padding(30)
                   
            }.frame(height: UIScreen.main.bounds.height * 0.2)
            Spacer()
            Button {
                showingSheet.toggle()
                lifts.append(Lift(name: inputName, date: insertDate, numberSets: Int(inputSets) ?? -1, muscles: selectedMuscles, numberPRs: Int(inputPRs) ?? -1))
                selectedMuscles = []
                inputName = ""
                inputSets = ""
                inputPRs = ""
                inputDate = ""
            } label: {
                Text("Finish")
                    .foregroundStyle(.cyan)
            }.padding(.top, 300)
                .frame(maxWidth: .infinity)
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding(10)
            .background(.black)
            
    }
    
    var topButtonHStack: some View {
        HStack {
            Button {
                print("Clicked Edit")
            } label: {
                Text("Edit")
                    .foregroundStyle(.cyan)
            }
            
            Spacer()
            
            Button {
                print("Clicked plus")
                showingSheet.toggle()
            } label: {
                Image(systemName: "plus.circle")
                    .foregroundStyle(.cyan)
            }
        }
    }
    
    var belowTitleHStack: some View {
        HStack {
            Text("2025")
                .foregroundStyle(.gray)
            Spacer()
            Text("1 Workout")
                .foregroundStyle(.gray)
        }
    }
    
    
}

struct WorkoutCard: View {
    var workout: any Workout
    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(red: 0.1, green: 0.1, blue: 0.1))
                .frame(height: UIScreen.main.bounds.height * 0.16)
            HStack(alignment: .top) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.clear)
                        .stroke(.white)
                        .frame(width: UIScreen.main.bounds.width * 0.125, height: UIScreen.main.bounds.width * 0.125)
                        
                    VStack {
                        Text("\(workout.date.monthDayMultiline())")
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.center)
                            .padding(.top, 1)
                    }
                }.frame(width: UIScreen.main.bounds.width * 0.15, height: UIScreen.main.bounds.width * 0.15)
                    .padding(.trailing, 4)
                VStack(alignment: .leading) {
                    Text(workout.name)
                        .bold()
                        .font(.system(size: 25))
                        .foregroundStyle(.white)
                    Text(workout.topSummary)
                        .foregroundStyle(.white)
                    Text(workout.midSummary)
                        .foregroundStyle(.white)
                    Text(workout.botSummary)
                        .foregroundStyle(.white)
                }
                Spacer()
                Text("90 min")
                    .foregroundStyle(.gray)
            }.padding(10)
            
        }
    }
}

struct LiftView: View {
    @Binding var lift: Lift
    @Environment(\.dismiss) var dismiss
    
    var onDelete: (() -> Void)?
    
    var body: some View {
        ZStack (alignment: .top) {
            Color.black.ignoresSafeArea()
            VStack(alignment: .leading) {
                TextField("Name", text: $lift.name)
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.white)
                    
                DatePicker("Start Date: ", selection: $lift.date, displayedComponents: .date)
                    .foregroundStyle(Color(red: 0.6, green: 0.6, blue: 0.6))
                    .colorScheme(.dark)
                
                HStack {
                    Text("Muscles:")
                        .foregroundStyle(Color(red: 0.6, green: 0.6, blue: 0.6))
                    Spacer()
                    NavigationLink(destination: MuscleSelectionView(selectedMuscles: $lift.muscles)) {
                        Text("Select Muscles")
                            .foregroundStyle(.white)
                            .padding(5)
                            .background(Color(red: 0.15, green: 0.15, blue: 0.15))
                            .cornerRadius(10)
                            
                    }
                    .buttonStyle(.plain)
                    .frame(alignment: .trailing)

                }
                
                Stepper("Number of Sets: \(lift.numberSets)", value: $lift.numberSets)
                    .foregroundStyle(Color(red: 0.6, green: 0.6, blue: 0.6))

                Stepper("Number of PRs: \(lift.numberPRs)", value: $lift.numberPRs)
                    .foregroundStyle(Color(red: 0.6, green: 0.6, blue: 0.6))

                HStack {
                    Spacer()
                    
                    Button {
                        onDelete?()
                        dismiss()
                    } label: {
                        Label("Delete", systemImage: "trash")
                            .foregroundStyle(.white)
                            .font(.headline)
                            .padding(.horizontal, 10)
                    }
                    .buttonStyle(.plain)
                    
                    Spacer()
                    
                    Button {
                        dismiss()
                    } label: {
                        Label("Submit", systemImage: "checkmark")
                            .foregroundStyle(.cyan)
                            .font(.headline)
                            .padding(.horizontal, 10)
                    }
                    .buttonStyle(.plain)
                    
                    Spacer()
                }
                .padding(.top, 20)
                
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .top)
        }
        
    }
    
}

struct MuscleSelectionView: View {
    @Binding var selectedMuscles: [Muscle]
    
    let allMuscles: [Muscle] = [
        .chest, .triceps, .biceps,
        .shoulders, .quads, .hamstrings,
        .back
    ]

    var body: some View {
        VStack(spacing: 20) {
            Text("Select Muscles")
                .font(.title)
                .foregroundStyle(.white)
                .padding(.top, 20)

            VStack(spacing: 15) {
                HStack(spacing: 10) {
                    ForEach(allMuscles.prefix(3), id: \.self) { muscle in
                        muscleButton(muscle)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)

                HStack(spacing: 10) {
                    ForEach(allMuscles.dropFirst(3).prefix(3), id: \.self) { muscle in
                        muscleButton(muscle)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)

                HStack(spacing: 10) {
                    ForEach(allMuscles.dropFirst(6), id: \.self) { muscle in
                        muscleButton(muscle)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 25)
            }

            Spacer()
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.ignoresSafeArea())
        .navigationTitle("Select Muscles")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func muscleButton(_ muscle: Muscle) -> some View {
        Button {
            toggleMuscle(muscle)
        } label: {
            Text(muscle.displayName)
                .foregroundStyle(.white)
                .padding(.vertical, 8)
                .frame(width: 100)
                .background(selectedMuscles.contains(muscle)
                            ? Color.cyan
                            : Color(red: 0.15, green: 0.15, blue: 0.15))
                .cornerRadius(10)
        }
        .buttonStyle(.plain)
    }

    private func toggleMuscle(_ muscle: Muscle) {
        if selectedMuscles.contains(muscle) {
            selectedMuscles.removeAll { $0 == muscle }
        } else {
            selectedMuscles.append(muscle)
        }
    }
}




#Preview {
    LogView()
}
