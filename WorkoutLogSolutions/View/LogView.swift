//
//  LogView.swift
//  WorkoutLogSolutions
//
//  Created by Victoria Lu on 2025-10-13.
//

import SwiftUI


struct LogView: View {
    @StateObject var viewModel = UserViewModel()
    @State var lifts: [Lift] = [
        Lift(name: "Push", date: Date.from(year: 2025, month: 6, day: 2), numberSets: 15, muscles: [.chest, .biceps, .triceps], numberPRs: 2),
        Lift(name: "Pull", date: Date.from(year: 2025, month: 6, day: 3), numberSets: 15, muscles: [.chest, .biceps, .triceps], numberPRs: 2),
        Lift(name: "Legs", date: Date.from(year: 2025, month: 6, day: 4), numberSets: 15, muscles: [.chest, .biceps, .triceps], numberPRs: 2)
    ]

    let cardios: [Cardio] = [
        Cardio(name: "Elliptical", date: Date.from(year: 2025, month: 8, day: 20), minutes: 30, calories: 250, maxHeartRate: 140),
        Cardio(name: "Seated Bike", date: Date.from(year: 2025, month: 8, day: 19), minutes: 45, calories: 400, maxHeartRate: 160)
    ]

    @State var showingSheet: Bool = false
    @State var inputName: String = ""
    @State var inputSets: String = ""
    @State var inputPRs: String = ""
    @State var inputDate: Date = Date()

    
    @State private var selectedSegment: Segment = .lifts

    enum Segment: String, CaseIterable, Identifiable {
        case lifts = "Lifts"
        case cardio = "Cardio"
        
        var id: String { self.rawValue }
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                topButtonHStack
                Text("June Log")
                    .font(.system(size: 35))
                    .bold()
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 10)

                belowTitleHStack.padding(.top, 4)

                Picker("Segment", selection: $selectedSegment) {
                    ForEach(Segment.allCases) { segment in
                        Text(segment.rawValue).tag(segment)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.vertical)

                ScrollView {
                    VStack(spacing: 10) {
                        if selectedSegment == .lifts {
                            ForEach(viewModel.sortWorkouts(lifts)) { lift in
                                LiftCard(lift: lift)
                            }
                        } else {
                            ForEach(viewModel.sortWorkouts(cardios)) { cardio in
                                CardioCard(cardio: cardio)
                            }
                        }
                    }
                }

            }
            .padding(.horizontal, 10)
            .frame(width: geometry.size.width, height: geometry.size.height)
            .background(.black)
            .sheet(isPresented: $showingSheet) {
                sheetView.background(Color(red: 0.1, green: 0.1, blue: 0.1))
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
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(red: 0, green: 0, blue: 0))
                VStack {
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
                        Text("Start Date: ")
                            .foregroundStyle(Color(red: 0.6, green: 0.6, blue: 0.6))
                        
                        DatePicker(
                            "",
                            selection: $inputDate,
                            displayedComponents: .date
                        )
                        .labelsHidden()
                        .datePickerStyle(.compact)
                        .colorScheme(.dark)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)

                }
                .frame(maxHeight: .infinity, alignment: .top)
                .padding(25)
                

            }.frame(height: UIScreen.main.bounds.height * 0.2)
            Button {
                showingSheet.toggle()
                lifts.append(Lift(name: inputName, date: inputDate, numberSets: Int(inputSets) ?? -1, muscles: [], numberPRs: Int(inputPRs) ?? -1))
                inputName = ""
                inputSets = ""
                inputPRs = ""
                inputDate = Date()
            } label: {
                Text("Finish")
                    .foregroundStyle(.cyan)
            }.padding(.top, 20)
                .frame(maxWidth: .infinity)
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding(10)
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
            Text("June 2025")
                .foregroundStyle(.gray)
            Spacer()
            Text("1 Workout")
                .foregroundStyle(.gray)
        }
    }


}

#Preview {
    LogView()
}
