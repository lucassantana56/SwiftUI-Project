//
//  MyWordList.swift
//  myword.ios
//
//  Created by Lucas Santana on 23/01/2021.
//

import SwiftUI

struct MyWordList: View {
    @ObservedObject var viewModel = MyWordListViewModel()
    @State private var searchText = ""
    
    var body: some View {
        VStack(){
            if viewModel.HasWords {
                SearchBarView(text: $searchText)
                    .padding(.top)
                List(){
                    ForEach(viewModel.myWordObject.filter({ searchText.isEmpty ? true : $0.photoWords.lowercased().contains(searchText.lowercased()) })){ wordItem in
                        AsyncImage(url: (URL(string:wordItem.url))!,
                                   placeholder: {  ProgressView() },
                                   image: { Image(uiImage: $0).resizable() })
                            .scaledToFill()
                            .frame(minWidth: 0,
                                   maxWidth: .infinity,
                                   minHeight: 0,
                                   maxHeight: 250,
                                   alignment: .topLeading)
                        Text(wordItem.photoWords)
                            .font(.title)
                            .multilineTextAlignment(.center)
                        Button(action: {viewModel.delete(photoId: wordItem.id)}) {
                            Text("Delete").font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: 300, height: 50)
                                .background(Color.red)
                                .cornerRadius(10.0)
                        }.buttonStyle(PlainButtonStyle())
                    }
                }}}.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            .edgesIgnoringSafeArea([.bottom])
            .onAppear(perform: {
                viewModel.loadData()
            }).navigationBarHidden(true)
    }
}

struct MyWordList_Previews: PreviewProvider {
    static var previews: some View {
        MyWordList()
    }
}

