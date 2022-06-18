//
//  CardItem.swift
//  TodoLater
//
//  Created by Pavel Raspaev on 08.06.2022.
//

import Foundation
import SwiftUI

enum CardType: Hashable {
    case personal, work, house
    
    var name: String {
        switch self {
            case .personal: return "Personal"
            case .work: return "Work"
            case .house: return "House"
        }
    }
    
    var icon: String {
        switch self {
            case .personal: return "user"
            case .work: return "bag"
            case .house: return "house"
        }
    }
    
    var animation: String {
        switch self {
            case .personal: return "rocket"
            case .work: return "sad"
            case .house: return "jump"
        }
    }
    
    var linearGradient: LinearGradient {
        switch self {
            case .personal: return Color.linearGradients.personal
            case .work: return Color.linearGradients.work
            case .house: return Color.linearGradients.house
        }
    }
    
    var gradient: Gradient {
        switch self {
            case .personal: return Color.gradients.personal
            case .work: return Color.gradients.work
            case .house: return Color.gradients.house
        }
    }
    
    var color: Color {
        switch self {
            case .personal: return Color("GR_Personal2")
            case .work: return Color("GR_Work2")
            case .house: return Color("GR_House2")
        }
    }
    
    
}
