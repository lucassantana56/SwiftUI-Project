//  LoginView.swift
//  myword.ios
//
//  Created by Lucas Santana on 27/12/2020.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
    let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)

    var body: some View {
        VStack(alignment: .center){
            TextField("UserName", text: $viewModel.userName )
                .padding()
                .background(lightGreyColor)
                .cornerRadius(5.0)
                .padding(.bottom, 10)
                .frame(width: 350, height: 50)
            
            SecureField("Password", text: $viewModel.password)
                .padding()
                .background(lightGreyColor)
                .cornerRadius(5.0)
                .padding(.bottom, 10)
                .frame(width: 350, height: 50)
            
            NavigationLink(destination:  HomeView(),isActive:$viewModel.willMoveToNextHome ) {
                       Text("")
                   }
            Button(action: {viewModel.Login()}) {
                Text("Login").font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.green)
                    .cornerRadius(10.0)
            }.buttonStyle(PlainButtonStyle())
            HStack{
                Text("Not registered yet?").foregroundColor(.black).font(.system(size: 20))
                
                NavigationLink(
                    destination: RegisterView(),
                    label: {
                        Text("Register").foregroundColor(Color.blue).font(.system(size: 20))
                    })
            }.padding()
           
        }
        .alert(isPresented: $viewModel.loginFailed) {
                   Alert(title: Text("Login Failed"), message: Text("try again"), dismissButton: .default(Text("OK")))
               }
        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: .infinity, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: .infinity, maxHeight: .infinity, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).background(Color.white).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
