//
//  Color.swift
//  TodoLater
//
//  Created by Pavel Raspaev on 06.06.2022.
//

import Foundation
import SwiftUI

extension Color {
    static let theme = ColorTheme()
    static let gradients = GradientsTheme()
    static let linearGradients = LinearGradientsTheme()
}

struct ColorTheme {
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let green = Color("GreenColor")
    let red = Color("RedColor")
    let secondaryText = Color("SecondaryTextColor")
}

struct GradientsTheme {
    let personal = Gradient(colors: [Color("GR_Personal1"), Color("GR_Personal2")])
    let work = Gradient(colors: [Color("GR_Work1"), Color("GR_Work2")])
    let house = Gradient(colors: [Color("GR_House1"), Color("GR_House2")])
}

private let starting: UnitPoint = .bottomLeading
private let ending: UnitPoint = .topTrailing

struct LinearGradientsTheme {
    let personal = LinearGradient(gradient: Color.gradients.personal, startPoint: starting, endPoint: ending)
    let work = LinearGradient(gradient: Color.gradients.work, startPoint: starting, endPoint: ending)
    let house = LinearGradient(gradient: Color.gradients.house, startPoint: starting, endPoint: ending)
}
