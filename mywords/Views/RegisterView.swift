//
//  RegisterView.swift
//  myword.ios
//
//  Created by Lucas Santana on 27/12/2020.
//

import SwiftUI

struct RegisterView: View {
    @State private var shouldPresentImagePicker = false
    @State private var shouldPresentActionScheet = false
    @State private var shouldPresentCamera = false
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @StateObject var viewModel = RegisterViewModel()
    let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)
    var body: some View {
        VStack(alignment: .center){
            
            viewModel.image!
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 202, height: 200)
                .clipShape(Circle()).padding()
                .shadow(radius: 10)
                .onTapGesture { self.shouldPresentActionScheet = true }
                .sheet(isPresented: $shouldPresentImagePicker) {
                    SUImagePickerView(sourceType: self.shouldPresentCamera ? .camera : .photoLibrary, image: $viewModel.image, isPresented: self.$shouldPresentImagePicker)
                }.actionSheet(isPresented: $shouldPresentActionScheet) { () -> ActionSheet in
                    ActionSheet(title: Text("Choose mode"), message: Text("Please choose your preferred mode to set your profile image"), buttons: [ActionSheet.Button.default(Text("Camera"), action: {
                        self.shouldPresentImagePicker = true
                        self.shouldPresentCamera = true
                    }), ActionSheet.Button.default(Text("Photo Library"), action: {
                        self.shouldPresentImagePicker = true
                        self.shouldPresentCamera = false
                    }), ActionSheet.Button.cancel()])
                }
            
            TextField("User Name", text: $viewModel.userName )
                .padding()
                .background(lightGreyColor)
                .cornerRadius(5.0)
                .padding(.vertical, 10)
                .frame(width: 350, height: 50)
            
            SecureField("Password", text:
                            $viewModel.password)
                .padding()
                .background(lightGreyColor)
                .cornerRadius(5.0)
                .padding(.vertical, 10)
                .frame(width: 350, height: 50)
            SecureField("Confirm password", text:
                            $viewModel.confirmPasword)
                .padding()
                .background(lightGreyColor)
                .cornerRadius(5.0)
                .padding(.vertical, 10)
                .frame(width: 350, height: 50)
            
            Button(action: {viewModel.Register()}) {
                Text("Sign Up")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .frame(width: 300, height: 50)
                    .background(Color.green)
                    .cornerRadius(10.0)}
            
            HStack{
                NavigationLink(destination:  HomeView(),isActive:$viewModel.willMoveToNextHome ) {
                           Text("")
                       }
                Text("Already registered ?").foregroundColor(.black).font(.system(size: 20))
                Text("login").foregroundColor(Color.red).font(.system(size: 20)).onTapGesture(count: 1, perform: {
                    self.mode.wrappedValue.dismiss()
                })
            }.padding()
            
        }.alert(isPresented: $viewModel.loginFailed) {
            Alert(title: Text("Register Failed"), message: Text("try again"), dismissButton: .default(Text("OK")))
        }
        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: .infinity, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: .infinity, maxHeight: .infinity, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).background(Color.white).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
