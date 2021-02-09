//
//  HomeView.swift
//  myword.ios
//
//  Created by Lucas Santana on 27/12/2020.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = LoadImageViewModel()
    @State private var currentView: Tab = .Tab1
    var body: some View {
        NavigationView {
            VStack {
                CurrentScreen(currentView: self.$currentView)
                TabBar(currentView: self.$currentView, showModal: $viewModel.showModal)
            }
        }
        .padding()
        .navigationBarHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
        .sheet(isPresented: $viewModel.showModal) { LoadImageView() }
    }
    
    struct HomeView_Previews: PreviewProvider {
        static var previews: some View {
            HomeView()
        }
    }
}
