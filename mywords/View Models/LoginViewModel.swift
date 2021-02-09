
import Foundation
import SwiftUI

struct LoginRequest : Encodable {
    var username = ""
    var password = ""
}

struct LoginReponse: Codable {
    let id : String
    
}

let BASEURL = "http://192.168.1.102:8081/api"


class LoginViewModel : ObservableObject {
    @Published var userName = ""
    @Published var password = "";
    @Published var willMoveToNextHome = false
    @Published var loginFailed = false
    
    func Login(){
        var loginRequest = LoginRequest()
        print("username: " + userName)
        print(password)
        loginRequest.username = userName
        loginRequest.password = password
        
        guard let encoded = try? JSONEncoder().encode(loginRequest) else {
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "\(BASEURL)/user/login")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        
        URLSession.shared.dataTask(with: request) { [self] data, response, error in
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
                let kc = Keychain()
                kc.setPasscode(id: StrUsernameKey, passcode: userName)
                kc.setPasscode(id: StrUserIDKey, passcode: decodedLogin.id)
                self.willMoveToNextHome = true
            } else {
                print("Invalid response from server")
                self.loginFailed = true
                
            }
        }.resume()
        
        
    }
    
}
