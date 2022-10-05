//
//  TwilioManager.swift
//  Messenger
//
//  Created by James Ogilvie on 4/10/2022.
//

import Foundation
import Alamofire

final class TwilioManager{
    public static let shared = TwilioManager()
}

extension TwilioManager {
    
    public func sendSMS(to: String, from: String, body: Any, SID: String, userAuthToken: String) {
        
        let userSID = SID
        let AuthToken = userAuthToken
        
        let parameters = [
          "To": to,
          "From": from,
          "Body": body]
        
        AF.request("https://\(userSID):\(AuthToken)@api.twilio.com/2010-04-01/Accounts/\(userSID)/Messages.json", method: .post, parameters: parameters).response { response in
            print(response)
        }
        print("sent?")
        return
      }
    
}


/* WORKING!!! IN VIEWDIDLOAD IN CHATVIEWCONTROLLER
private func sendSMS() {
    
//        let SID = "AC9161e2b64c4aa8c0d24b8a66fcb081b5"
//        let AuthToken = "16d14ad1c7bbbf932c11146a47a1ab47"
    
    let parameters = [
      "To": "+61403143359",
      "From": "+13856666341",
      "Body": "This is a message test"]
    
    AF.request("https://AC9161e2b64c4aa8c0d24b8a66fcb081b5:16d14ad1c7bbbf932c11146a47a1ab47@api.twilio.com/2010-04-01/Accounts/AC9161e2b64c4aa8c0d24b8a66fcb081b5/Messages.json", method: .post, parameters: parameters).response { response in
        print(response)
    }
    print("sent?")
    return
  }
*/





//guard let url = URL(string: "https://api.twilio.com/2010-04-01/Accounts/AC9161e2b64c4aa8c0d24b8a66fcb081b5/Messages.json")
//
//      //let payload = "{AC9161e2b64c4aa8c0d24b8a66fcb081b5:16d14ad1c7bbbf932c11146a47a1ab47}".data(using: .utf8)
//else {
//          return
//      }
//
//let username = "AC9161e2b64c4aa8c0d24b8a66fcb081b5"
//let password = "16d14ad1c7bbbf932c11146a47a1ab47"
//let loginString = String(format: "%@:%@", username, password)
//let loginData = loginString.data(using: String.Encoding.utf8)!
//let base64LoginString = loginData.base64EncodedString()
//
//// create the request
//var request = URLRequest(url: url)
//request.httpMethod = "POST"
//request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
//request.setValue(<#T##value: String?##String?#>, forHTTPHeaderField: <#T##String#>)
//
//let endOfUrlText = "\(request)To=+61403143359&From=+13856666341&Body=Hi"
//// fire off the request
//// make sure your class conforms to NSURLConnectionDelegate
////let urlConnection = NSURLConnection(request: request, delegate: self)
//
//print(request)
//URLSession.shared.dataTask(with: request) { (data, response, error) in
//    guard error == nil else {
//        print(error!.localizedDescription)
//        return
//    }
//    guard let data = data else {
//        print("Empty data")
//        return
//    }
//
//    if let str = String(data: data, encoding: .utf8) {
//        print(str)
//    }
//}.resume()
//

// prepare json data
//let json: [String: Any] = ["To": "+61403143359",
//                           "From": "+13856666341",
//                           "Body": "Hello"]
//
//let jsonData = try? JSONSerialization.data(withJSONObject: json)
//
//// create post request
//
//public func sendForUrlText() {
//
//    let url = URL(string: "https://api.twilio.com/2010-04-01/Accounts/AC9161e2b64c4aa8c0d24b8a66fcb081b5/Messages.json")!
//    var request = URLRequest(url: url)
//    request.httpMethod = "POST"
//
//    // insert json data to the request
//    request.httpBody = jsonData
//
//    let task = URLSession.shared.dataTask(with: request) { data, response, error in
//        guard let data = data, error == nil else {
//            print(error?.localizedDescription ?? "No data")
//            return
//        }
//        let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
//        if let responseJSON = responseJSON as? [String: Any] {
//            print(responseJSON)
//        }
//    }
//
//    task.resume()
//
//
//}
//
//public func sendForUrlText() {
//
//    print("hello")
//        if let accountSID = ProcessInfo.processInfo.environment["AC9161e2b64c4aa8c0d24b8a66fcb081b5"],
//           let authToken = ProcessInfo.processInfo.environment["16d14ad1c7bbbf932c11146a47a1ab47"] {
//
//          let url = "https://api.twilio.com/2010-04-01/Accounts/\(accountSID)/Messages"
//          let parameters = ["From": "+13856666341", "To": "+61403143359", "Body": "Hello from Swift!"]
//
//          AF.request(url, method: .post, parameters: parameters)
//            .authenticate(username: accountSID, password: authToken)
//            .responseData { response in
//              debugPrint(response)
//                print("hello")
//                return
//          }
//
//            print("Is is working?")
//            return
//          //RunLoop.main.run()
//        }
//}
