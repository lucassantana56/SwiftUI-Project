//
//  ProfileViewModel.swift
//  mywords
//
//  Created by Lucas Santana on 03/02/2021.
//

import Foundation
import SwiftUI

struct UserReponse: Codable  {
    let url: String
    let userName: String
}

class ProfileViewModel : ObservableObject{
    @Published var image: Image? = Image("profile")
    @Published var userName = "Jonh Doe"
    @Published var url = ""
    @Published var showProfileImage = false
    @Published var ServiceFailed = false
    
    func loadData() {
        let kc = Keychain()
        let username = kc.getPasscode(id: StrUserIDKey)
        let url = URL(string: "\(BASEURL)/user/info?userid=\(username)")!
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
            
            
            if let decodedUser = try? JSONDecoder().decode(UserReponse.self, from: data) {
                print("sucees \(decodedUser.url)")
                self.userName = decodedUser.userName
                self.url = decodedUser.url
                self.showProfileImage = true
            } else {
                print("Invalid response from server")
                self.ServiceFailed = true
            }
        }.resume()
    }
}
