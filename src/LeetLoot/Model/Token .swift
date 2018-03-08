//
//  Token .swift
//  LeetLoot
//
//  Created by Kiarash Teymoury on 3/7/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import UIKit

class Token: NSObject {
        
    private func initalizeUserCredintials() -> [String:String] {
        let client_id = "KiarashT-LeetLoot-PRD-7134e8f72-d2c368b6",
            client_secret = "PRD-134e8f72df02-4cbd-4755-8e7b-aa12",
            auth = client_id + ":" + client_secret,
            data = (auth).data(using: String.Encoding.utf8),
            base64 = data?.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0)),
            authString2 = "Basic \(base64 ?? "")"
        
        return ["Authorization" : authString2]
    }
    
    func getToken(completion: @escaping ((String)) -> Void) {
        guard let serviceUrl = URL(string: "https://api.ebay.com/identity/v1/oauth2/token") else { return }
        
        var request = URLRequest(url: serviceUrl)
            request.httpMethod = "POST"
            request.httpBody = "grant_type=client_credentials&scope=https://api.ebay.com/oauth/api_scope".data(using: .utf8)
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            request.allHTTPHeaderFields = initalizeUserCredintials()
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    if  let data = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                        let token = data["access_token"] as? String {
                        DispatchQueue.main.async {
                            completion(token)
                        }
                    }
                }catch {
                    print(error)
                }
            }
        }.resume()
    }
}
