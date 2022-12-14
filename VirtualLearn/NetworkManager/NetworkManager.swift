//
//  NetworkManager.swift
//  VirtualLearn
//
//  Created by Manish R T on 06/12/22.
//

import Foundation

class NetWorkManager {
    
    func fetchData(request: URLRequest, completion: @escaping (Any) -> (), failure: @escaping (Any) -> ()) {
    
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error == nil{
                          let httpResponse = response as! HTTPURLResponse
                          guard let responsedata = data else { return }
                          print(httpResponse.statusCode)
                          if(httpResponse.statusCode == 200){
                            let data = String(data: responsedata, encoding: .utf8)!.components(separatedBy: .newlines)
                            completion(data)
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
    

    func postData(url: String, requestMethod: String, parameters: [String: Any], headers: [String: String]?, completion: @escaping(Any? , Error?) -> Void) {

           let boundary = "Boundary-\(UUID().uuidString)"
           var request = URLRequest(url: URL(string: url)!)
           request.httpMethod = requestMethod
           request.setValue("application/json", forHTTPHeaderField: "Content-Type")
           let httpBody = NSMutableData()
           for (key, value) in parameters {
               httpBody.appendString(convertFormField(named: key, value: value, using: boundary))
           }

           httpBody.appendString("--\(boundary)--")
           request.httpBody = httpBody as Data
           request.allHTTPHeaderFields = headers
           URLSession.shared.dataTask(with: request) { data, response, error in
               if let response = response as? HTTPURLResponse {
                print(response.statusCode)
                if (response.statusCode == 200 || response.statusCode == 201) {
                  let data = String(data: data!, encoding: .utf8)!.components(separatedBy: .newlines)
                   completion(data[0],nil)
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
                print("Response", response.statusCode)
                if (response.statusCode == 200 || response.statusCode == 201) {
                let reponseData = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
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
                
                          if(httpResponse.statusCode == 200){
                            let data = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments)
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
