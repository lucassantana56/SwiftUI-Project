//
//  MyWordListViewModel.swift
//  mywords
//
//  Created by Lucas Santana on 04/02/2021.
//

import Foundation

struct DeleteRequest : Encodable {
    var userId = ""
    var id = ""
}

class MyWordListViewModel : ObservableObject{
    @Published var myWordObject: [Word] = []
    @Published var ServiceFailed = false
    @Published var HasWords = false
    
    public func delete(photoId : String){
        var deleteRequest = DeleteRequest()
        let kc = Keychain()
        let username = kc.getPasscode(id: StrUserIDKey)
        deleteRequest.id = photoId
        deleteRequest.userId = username as String
        guard let encoded = try? JSONEncoder().encode(deleteRequest) else {
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "\(BASEURL)/photo/delete")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        
        URLSession.shared.dataTask(with: request) { [self] data, response, error in
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error").")
                return
            }
            self.myWordObject.removeAll(where: { $0.id == photoId })
        }.resume()
    }
    
    public func loadData() {
        let kc = Keychain()
        let username = kc.getPasscode(id: StrUserIDKey)
        let url = URL(string: "\(BASEURL)/photo/get?userid=\(username)")!
        var request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error").")
                return
            }
            
            if let string = String(data: data, encoding: .utf8) {
                print(string)
            } else {
                print("not a valid UTF-8 sequence")
            }
            
            
            if let myWordResponse = try? JSONDecoder().decode(MyWord.self, from: data) {
                print("sucess \(myWordResponse)")
                DispatchQueue.main.async {
                    print(myWordResponse.data)
                    if(myWordResponse.data.count > 0){
                        self.HasWords = true
                        for word in myWordResponse.data{
                            print(word)
                            self.myWordObject.append(word)
                        }
                        
                    }
                }
            } else {
                print("Invalid response from server")
                self.ServiceFailed = true
            }
        }.resume()
        
    }
}
