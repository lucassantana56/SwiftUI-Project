//
//  ContentView.swift
//  mywords
//
//  Created by Lucas Santana on 23/01/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            LoginView()
        }.navigationBarHidden(true)
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
