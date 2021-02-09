//
//  RegisterViewModel.swift
//  mywords
//
//  Created by Lucas Santana on 03/02/2021.
//

import Foundation
import SwiftUI

struct RegisterReponse: Codable {
    let id : String
    
}

class RegisterViewModel : ObservableObject{
    @Published var image: Image? = Image("profile")
    @Published var userName = ""
    @Published var password = ""
    @Published var confirmPasword = ""
    @Published var willMoveToNextHome = false
    @Published var loginFailed = false
    
    func Register(){
        let boundary = "Boundary-\(UUID().uuidString)"
        let url = URL(string: "\(BASEURL)/user/register")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        _ = "image/jpg"
        
        let params: [String : String]? = [
            "username" : userName,
            "password" : password
        ]
        let postImage = PostImage()
        let imageData = image?.asUIImage().jpegData(compressionQuality: 1)
        let filename = "testeImg"
        
        let httpBody = NSMutableData()
        
        for (key, value) in params! {
            httpBody.appendString(postImage.convertFormField(named: key, value: value, using: boundary))
        }
        
        httpBody.append(postImage.convertFileData(fieldName: "img",
                                                  fileName: "\(filename).png",
                                                  mimeType: "image/png",
                                                  fileData: imageData!,
                                                  using: boundary))
        
        httpBody.appendString("--\(boundary)--")
        
        request.httpBody = httpBody as Data
        
        print(String(data: httpBody as Data, encoding: .utf8) ?? "er")
        
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
            
            if let decodedLogin = try? JSONDecoder().decode(RegisterReponse.self, from: data) {
                print("sucees \(decodedLogin.id)")
                let kc = Keychain()
                kc.setPasscode(id: StrUsernameKey, passcode: self.userName)
                kc.setPasscode(id: StrUserIDKey, passcode: decodedLogin.id)
                self.willMoveToNextHome = true
            } else {
                print("Invalid response from server")
                self.loginFailed = true
            }
        }.resume()
        
    }
}
