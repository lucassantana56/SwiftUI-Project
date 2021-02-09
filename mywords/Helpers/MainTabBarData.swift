//
//  MainTabBarData.swift
//  mywords
//
//  Created by Lucas Santana on 07/02/2021.
//

import Foundation
import SwiftUI
import UIKit
import Combine

final class MainTabBarData: ObservableObject {

    /// This is the index of the item that fires a custom action
    let customActionteminidex: Int

    let objectWillChange = PassthroughSubject<MainTabBarData, Never>()

    var itemSelected: Int {
        didSet {
            if itemSelected == customActionteminidex {
                itemSelected = oldValue
                isCustomItemSelected = true
            }
            objectWillChange.send(self)
        }
    }

    /// This is true when the user has selected the Item with the custom action
    var isCustomItemSelected: Bool = false

    init(initialIndex: Int = 1, customItemIndex: Int) {
        self.customActionteminidex = customItemIndex
        self.itemSelected = initialIndex
    }
}
