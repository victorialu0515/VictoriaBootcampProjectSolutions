//
//  CardioCard.swift
//  WorkoutLogSolutions
//
//  Created by Victoria Lu on 2025-10-13.
//

import SwiftUI

struct CardioCard: View {
    var cardio: Cardio
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
                        Text("\(cardio.date.formattedMonth())")
                            .foregroundStyle(.white)
                            .padding(.top, 1)
                        Text("\(cardio.date.formattedDay())")
                            .foregroundStyle(.white)
                            .padding(.bottom, 1)
                    }
                }.frame(width: UIScreen.main.bounds.width * 0.15, height: UIScreen.main.bounds.width * 0.15)
                    .padding(.trailing, 4)
                VStack(alignment: .leading) {
                    Text(cardio.name)
                        .bold()
                        .font(.system(size: 25))
                        .foregroundStyle(.white)
                    Text("\(cardio.minutes) Minutes Completed")
                        .foregroundStyle(.white)
                    Text("\(cardio.calories) Calories Burned")
                        .foregroundStyle(.white)
                    Text("\(cardio.maxHeartRate) BPM Max Heart Rate")
                        .foregroundStyle(.white)
                }
                Spacer()
                Text("90 min")
                    .foregroundStyle(.gray)
            }.padding(10)

        }
    }
}
