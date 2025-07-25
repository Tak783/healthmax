//
//  BloodTypePickerView.swift
//  QuizFeature
//
//  Created on 25/05/2025.
//

import CoreHealthMaxModels
import SwiftUI

struct BloodTypePickerView: View {
    @Binding var selectedBloodType: BloodType

    var body: some View {
        Picker("Blood Type", selection: $selectedBloodType) {
            ForEach(BloodType.allCases, id: \.self) { type in
                Text(type.displayName).tag(type)
            }
        }
        .pickerStyle(.wheel)
    }
}
