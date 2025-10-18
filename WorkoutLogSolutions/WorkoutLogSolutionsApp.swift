//
//  WorkoutLogApp.swift
//  WorkoutLog
//
//  Created by Alec Hance on 7/27/25.
//

import SwiftUI

@main
struct WorkoutLogApp: App {
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = .white
        UISegmentedControl.appearance().backgroundColor = .black

        let normalAttrs = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        let selectedAttrs = [
            NSAttributedString.Key.foregroundColor: UIColor.black
        ]

        UISegmentedControl.appearance().setTitleTextAttributes(normalAttrs, for: .normal)
        UISegmentedControl.appearance().setTitleTextAttributes(selectedAttrs, for: .selected)
        
        UIDatePicker.appearance().tintColor = .white // accent highlight
    }
    var body: some Scene {
        WindowGroup {
            LogView()
        }
    }
}
