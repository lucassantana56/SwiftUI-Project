//
//  TabBar.swift
//  mywords
//
//  Created by Lucas Santana on 07/02/2021.
//

import Foundation
import SwiftUI

struct TabBar: View {
    @Binding var currentView: Tab
    @Binding var showModal: Bool
    
    var body: some View {
        HStack {
            TabBarItem(currentView: self.$currentView, imageName: "list.bullet", paddingEdges: .leading, tab: .Tab1)
            Spacer()
            ShowModalTabBarItem(radius: 55) { self.showModal.toggle() }
            Spacer()
            TabBarItem(currentView: self.$currentView, imageName: "person", paddingEdges: .trailing, tab: .Tab2)
        }
        .frame(minHeight: 70)
    }
}
