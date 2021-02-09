//
//  LoadImageView.swift
//  myword.ios
//
//  Created by Lucas Santana on 19/01/2021.
//

import SwiftUI

struct LoadImageView: View {
    @StateObject var viewModel = LoadImageViewModel()
    @State private var shouldPresentImagePicker = false
    @State private var shouldPresentActionScheet = false
    @State private var shouldPresentCamera = false
    @Environment(\.presentationMode) private var presentationMode    
    var body: some View {
        VStack(alignment: .center) {
            viewModel.image!
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 300, height: 300)
                .clipShape(Rectangle())
                .overlay(Rectangle().stroke(Color.white, lineWidth: 4))
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
            Text(viewModel.words)
                .font(.largeTitle)
                .padding()
            Button(action: {viewModel.LoadImage()}) {
                Text("Process Image").font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.green)
                    .cornerRadius(10.0)
            }
            if(viewModel.showSaveButton){
                Button(action: {viewModel.Save()}) {
                    Text("Save").font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.green)
                        .cornerRadius(10.0)
                }
            }
        }.alert(isPresented: $viewModel.saved) {
            Alert(title: Text("Saved"), message: Text("Navigate to home "), dismissButton: .default(Text("OK"),
                                                                                                    action: {
                                                                                                        self.presentationMode.wrappedValue.dismiss()
                                                                                                    }))
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        .background(Color(.blue).opacity(0.5))
        .edgesIgnoringSafeArea(.all)
    }
    
    struct LoadImageView_Previews: PreviewProvider {
        static var previews: some View {
            LoadImageView()
        }
    }
}
