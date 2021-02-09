//
//  APIService.swift
//  mywords
//
//  Created by Lucas Santana on 31/01/2021.
//

import Foundation

class APIService : ObservableObject {
    
    
    func Login(username : String , password : String){
        var loginRequest = LoginRequest()
        print("username: " + username)
        print(password)
        loginRequest.username = username
        loginRequest.password = password
        
        guard let encoded = try? JSONEncoder().encode(loginRequest) else {
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "http://192.168.1.102:8081/api/user/login")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        
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
            
            
            if let decodedLogin = try? JSONDecoder().decode(LoginReponse.self, from: data) {
                print("sucees \(decodedLogin.id)")
                self.willMoveToNextHome = true
            } else {
                print("Invalid response from server")
                self.loginFailed = true
                
            }
        }.resume()
        
        
    }
