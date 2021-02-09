//
//  ProfileView.swift
//  mywords
//
//  Created by Lucas Santana on 03/02/2021.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @ObservedObject var viewModel = ProfileViewModel()
    @State var image:UIImage = UIImage()
    @State var isLinkActive = false
    
    let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)
    var body: some View {
        VStack(){
            if(!viewModel.showProfileImage){
                ProgressView()
            }else{
                AsyncImage(url: (URL(string:viewModel.url))!,
                           placeholder: { ProgressView()
                           },
                           image: { Image(uiImage: $0).resizable() })
                    .frame(width: 202, height: 200)
                    .clipShape(Circle()).padding()
                    .shadow(radius: 10)
            }
            Text(viewModel.userName).font(.largeTitle)
            NavigationLink(destination:  ContentView(), isActive: $isLinkActive ) {
                Button(action: {self.isLinkActive = true}) {
                    Text("Logout").font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.blue)
                        .cornerRadius(10.0)
                }
                
            }.buttonStyle(PlainButtonStyle())
        }.alert(isPresented: $viewModel.ServiceFailed) {
            Alert(title: Text("Register Failed"), message: Text("try again"), dismissButton: .default(Text("OK")))
        }.onAppear(perform: {
            viewModel.loadData()
        })
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        .edgesIgnoringSafeArea(.all)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

