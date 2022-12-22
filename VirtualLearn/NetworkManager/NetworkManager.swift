//
//  NetworkManager.swift
//  VirtualLearn
//
//  Created by Manish R T on 06/12/22.
//

import Foundation
import UIKit

class NetWorkManager {
    
    func fetchData(request: URLRequest, completion: @escaping (Any) -> (), failure: @escaping (Any) -> ()) {
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error == nil{
                let httpResponse = response as! HTTPURLResponse
                guard let responsedata = data else { return }
                if(httpResponse.statusCode == 401) {
                    
                }
                else if(httpResponse.statusCode == 200){
                    let data = String(data: responsedata, encoding: .utf8)!.components(separatedBy: .newlines)
                    
                    completion(data)
                }else if httpResponse.statusCode == 304 {
                    print("already joined the course")
                }else if httpResponse.statusCode == 404 {
                    print("course does not exist")
                    failure("course does not exist")
                }
                else{
                    
                    failure(String(data: responsedata, encoding: .utf8)!.components(separatedBy: .newlines))
                    print(httpResponse.statusCode)
                }
            }
            else{
                failure("Failed to register")
                print(error!.localizedDescription)
                
            }
        }.resume()
    }
    
    func convertFileData(fieldName: String, fileName: String, mimeType: String, fileData: Data, using boundary: String) -> Data {
        let data = NSMutableData()
        data.appendString("--\(boundary)\r\n")
        data.appendString("Content-Disposition: form-data; name=\"\(fieldName)\"; filename=\"\(fileName)\"\r\n")
        data.appendString("Content-Type: \(mimeType)\r\n\r\n")
        data.append(fileData)
        data.appendString("\r\n")
        return data as Data
    }
    
    func convertFormField(named name: String, value: Any, using boundary: String) -> String {
        var fieldString = "--\(boundary)\r\n"
        fieldString += "Content-Disposition: form-data; name=\"\(name)\"\r\n"
        fieldString += "\r\n"
        fieldString += "\(value)\r\n"
        return fieldString
    }
    
    
    func postData(url: String, requestMethod: String,profileImage:UIImage , parameters: [String: Any], token: String, headers: [String: String]?, completion: @escaping(Any? , Error?) -> Void) {
       let imageData = profileImage.jpegData(compressionQuality: 0.9)
        let boundary = "Boundary-\(UUID().uuidString)"
        var request = URLRequest(url: URL(string: url)!)
        let httpBody = NSMutableData()
        
        for (key, value) in parameters {
            httpBody.appendString(convertFormField(named: key, value: value, using: boundary))
        }
        
//        let data = NSMutableData()
//              let fieldName = "profileImage"
//                  if let imageData = profileImage.jpegData(compressionQuality: 1) {
//                      data.append("--\(boundary)\r\n".data(using: .utf8)!)
//                      data.append("Content-Disposition: form-data; name=\"\(fieldName)\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
//                      data.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
//                      data.append(imageData)
//                      data.append("\r\n".data(using: .utf8)!)
//                  }
        
        print(httpBody)
        if let image = imageData {
                    httpBody.append(convertFileData(fieldName: "profileImage",
                                                    fileName: "profile.jpeg",
                                                    mimeType: "img/png",
                                                    fileData: image,
                                                    using: boundary))}
        let image = photoDataToFormData(data: imageData!, boundary: boundary, fileName: "profile.jpeg")
        httpBody.append(image as Data)
        request.httpMethod = requestMethod
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        httpBody.appendString("--\(boundary)--")
        request.httpBody = httpBody as Data
        request.allHTTPHeaderFields = headers
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let response = response as? HTTPURLResponse {
                print(response.statusCode)
                let data8 = String(data: data!, encoding: .utf8)!.components(separatedBy: .newlines)
               print(data8,"fggh")
                if (response.statusCode == 200 || response.statusCode == 201) {
                    let data = String(data: data!, encoding: .utf8)!.components(separatedBy: .newlines)
                    print(data)
                    completion([0],nil)
                }
            }
            if error != nil {
                print(error?.localizedDescription as Any)
                completion(nil,error)
            }
        }.resume()
    }
    
    func requestData(request: URLRequest,completion: @escaping (Any) -> (), failure: @escaping (Any) -> ()) {
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let response = response as? HTTPURLResponse {
                
                guard let responsedata = data else {return}
                if(response.statusCode == 401) {
                    
                }
               else if (response.statusCode == 200 || response.statusCode == 201) {
                    let reponseData = try! JSONSerialization.jsonObject(with: responsedata, options: .mutableContainers)
                    completion(reponseData)
                }
                else{
                    failure("Fail")
                }
            }
            if error != nil {
                print(error?.localizedDescription as Any)
                
            }
        }.resume()
        
    }
    
    func fetchDataJson(request: URLRequest, completion: @escaping (Any) -> (), failure: @escaping (Any) -> ()) {
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error == nil{
                let httpResponse = response as! HTTPURLResponse
                
                guard let responsedata = data else { return }
                if(httpResponse.statusCode == 401) {
                    
                }
                
                else if(httpResponse.statusCode == 200){
                    let data = try! JSONSerialization.jsonObject(with: responsedata, options: .allowFragments)
                    
                    completion(data)
                    
                }
                else{
                    
                    failure(String(data: responsedata, encoding: .utf8)!.components(separatedBy: .newlines))
                    print(httpResponse.statusCode)
                }
            }
            else{
                print(error!.localizedDescription)
                
            }
        }.resume()
    }
}

extension NSMutableData {
    func appendString(_ string: String) {
        if let data = string.data(using: .utf8) {
            self.append(data)
        }
    }
}
extension Dictionary {
    func percentEscaped() -> String {
        return map { (key, value) in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
    }
    
    
    
}

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@"
        let subDelimitersToEncode = "!$&'()*+,;="
        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}

func photoDataToFormData(data: Data, boundary: String, fileName: String) -> NSData {
    var fullData = NSMutableData()
    // 1 - Boundary should start with --
    let lineOne = "--" + boundary + "\r\n"
    fullData.append(lineOne.data(
                        using: String.Encoding.utf8,
        allowLossyConversion: false)!)
    // 2
    let lineTwo = "Content-Disposition: form-data;  name=\"profileImage\"; filename=\"" + fileName + "\"\r\n"
    NSLog(lineTwo)
    fullData.append(lineTwo.data(
                        using: String.Encoding.utf8,
        allowLossyConversion: false)!)
    // 3

    let lineThree = "Content-Type: image/jpeg\r\n\r\n"
    fullData.append(lineThree.data(
                        using: String.Encoding.utf8,
        allowLossyConversion: false)!)
    fullData.append(data)
    // 5
    let lineFive = "\r\n"
    fullData.append(lineFive.data(
                        using: String.Encoding.utf8,
        allowLossyConversion: false)!)
    // 6 - The end. Notice -- at the start and at the end
    let lineSix = "--" + boundary + "--\r\n"
    fullData.append(lineSix.data(
                        using: String.Encoding.utf8,
        allowLossyConversion: false)!)
    return fullData

}
