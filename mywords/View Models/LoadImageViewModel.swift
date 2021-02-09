//
//  LoadImageViewModel.swift
//  mywords
//
//  Created by Lucas Santana on 31/01/2021.
//

import Foundation
import SwiftUI

struct SavePhotoRequest : Encodable {
    var userId = ""
    var photoWords =  ""
    var photoBASE64 = ""
}

extension NSMutableData {
    func appendString(_ string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
    }
}

class LoadImageViewModel : ObservableObject  {
    
    @Published var image: Image? = Image("placeholder")
    @Published var words = ""
    @Published var showSaveButton = false
    @Published var showModal = false
    @Published var saved = false
    var uiImage : UIImage? = UIImage(named:"placeholder")
    let model = MobileNetV2()
    
    func Save(){
        let kc = Keychain()
        let userId = kc.getPasscode(id: StrUserIDKey)
        print(kc.getPasscode(id: StrUserIDKey))
        
        let boundary = "Boundary-\(UUID().uuidString)"
        let url = URL(string: "\(BASEURL)/photo/add")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        _ = "image/jpg"
        
        let params: [String : String]? = [
            "userId" : userId as String,
            "photoWords" : words
        ]
        
        let imageData = uiImage?.jpegData(compressionQuality: 1)
        let filename = "testeImg"
        
        let httpBody = NSMutableData()
        let postImage = PostImage()
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
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error").")
                return
            }
            
            if let string = String(data: data, encoding: .utf8) {
                print(string)
                print("SUCESS")
                self.saved = true
            } else {
                print("not a valid UTF-8 sequence")
            }
        }.resume()
        
    }
    
    func LoadImage(){
        uiImage = image.asUIImage()
        let resizedImage = uiImage?.resizeTo(size: CGSize(width: 224, height: 224))
        let buffer = resizedImage?.buffer()!
        
        let output = try? model.prediction(image: buffer!)
        
        if let output = output {
            let res = output.classLabel
            print(res)
            words = res
            showSaveButton = true
        }
    }    
}
