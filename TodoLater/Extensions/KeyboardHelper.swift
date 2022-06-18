//
//  KeyboardHelper.swift
//  TodoLater
//
//  Created by Pavel Raspaev on 17.06.2022.
//

import Foundation
import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
