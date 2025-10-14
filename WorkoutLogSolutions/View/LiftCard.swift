//
//  WorkoutCard.swift
//  WorkoutLogSolutions
//
//  Created by Victoria Lu on 2025-10-13.
//

import SwiftUI

struct LiftCard: View {
    var lift: Lift
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
                        Text("\(lift.date.formattedMonth())")
                            .foregroundStyle(.white)
                            .padding(.top, 1)
                        Text("\(lift.date.formattedDay())")
                            .foregroundStyle(.white)
                            .padding(.bottom, 1)
                    }
                }.frame(width: UIScreen.main.bounds.width * 0.15, height: UIScreen.main.bounds.width * 0.15)
                    .padding(.trailing, 4)
                VStack(alignment: .leading) {
                    Text(lift.name)
                        .bold()
                        .font(.system(size: 25))
                        .foregroundStyle(.white)
                    Text("\(lift.numberSets) Total Sets")
                        .foregroundStyle(.white)
                    Text("\(lift.muscles.count) Muscles Hit")
                        .foregroundStyle(.white)
                    Text("\(lift.numberPRs) PRs")
                        .foregroundStyle(.white)
                }
                Spacer()
                Text("90 min")
                    .foregroundStyle(.gray)
            }.padding(10)

        }
    }
}

