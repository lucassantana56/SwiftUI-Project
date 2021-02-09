//
//  TabBarItem.swift
//  mywords
//
//  Created by Lucas Santana on 07/02/2021.
//

import Foundation
import SwiftUI

struct TabBarItem: View {
    @Binding var currentView: Tab
    let imageName: String
    let paddingEdges: Edge.Set
    let tab: Tab
    
    var body: some View {
        VStack(spacing:0) {
            Image(systemName: imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(5)
                .frame(width: 40, height: 40, alignment: .center)
                .foregroundColor(Color(self.currentView == tab ? .blue : .black))}
            .frame(width: 100, height: 50)
            .onTapGesture { self.currentView = self.tab }
            .padding(paddingEdges, 15)
    }
}
