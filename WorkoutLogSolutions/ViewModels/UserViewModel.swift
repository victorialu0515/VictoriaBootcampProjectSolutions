//
//  WorkoutViewModel.swift
//  WorkoutLog
//
//  Created by Alec Hance on 8/9/25.
//
import SwiftUI
import Foundation

class UserViewModel {
    var user: User
    var cardios: [Cardio]
    var lifts: [Lift]
    
    init(user: User, cardios: [Cardio], lifts: [Lift]) {
        self.user = user
        self.cardios = cardios
        self.lifts = lifts
    }
}
