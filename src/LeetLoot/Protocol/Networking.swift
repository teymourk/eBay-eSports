//
//  Networking.swift
//  LeetLoot
//
//  Created by Kiarash Teymoury on 2/11/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import UIKit

enum RequestRespnse: Error {
    case success(String)
    case error(String)
}

protocol Networking {
    associatedtype Model: Codable
    func requestData(forUrl url: URL, completion: @escaping (RequestRespnse, Model?) -> ())
    func decode(data: Data) -> Model?
}

extension Networking where Self == Model {
    
    private var token: String {
        return "v^1.1#i^1#f^0#r^0#p^1#I^3#t^H4sIAAAAAAAAAOVXfWwURRTv9QtJQYkCCgFsFwiC3b3Zvdu9u5U7c/RauVDawh0ViqbO7c62K3e7584c7UUwZ43FAImGhARBsTb+IVEDJIKBIJGAsSaNRoMaQ0z8/sDPkBCMYHB27yjXSvgsQuL9c5k3b978fr/33swOyFWOnde7sPfUeNeY0r4cyJW6XHwVGFtZce+tZaVTK0pAkYOrLzcrV95T9uN8DFPJtLwU4bRpYFTdnUoaWHaMQSZjGbIJsY5lA6YQlokix8KLG2WBA3LaMompmEmmOhoJMtDvU3ggCqLoVROa6qVW41zMuBlkAooI/ACI0KdoCVH00XmMMyhqYAINEmQEwPtZ4GGBFBcEmffKQOIEydfGVLciC+umQV04wIQcuLKz1irCenGoEGNkERqECUXDDbHmcDRS3xSf7y6KFSroECOQZPDwUZ2poupWmMygi2+DHW85llEUhDHjDuV3GB5UDp8DcxXwHakTkggTHk3VvD6/GJD4UZGywbRSkFwch23RVVZzXGVkEJ1kL6UoVSPxKFJIYdREQ0Qj1fbfkgxM6pqOrCBTvyC8ItzSwoQW6dCCuDPONiJEGk2TsC1LI6yP93iRX/MJrCooHsmfkAob5aMVZB6xU51pqLotGq5uMskCRFGjkdqAIm2oU7PRbIU1YiMa8vPFARjS0NtmJzWfxQzpNOy8ohQVotoZXjoDQ6sJsfREhqChCCMnHIloW6XTusqMnHRqsVA+3TjIdBKSlt3urq4ursvDmVaHWwCAdy9f3BhTOlEKMtTX7vW8v37pBazuUFEQXYl1mWTTFEs3rVUKwOhgQoIkejxiQffhsEIjrf8yFHF2D++I0eoQxZvgNRUFEFSVgCCB0eiQUKFI3TYOlIBZNgWtVYikk1BBrELrLJNClq7KHlETPH4NsaoU0FhvQNPYhKhKLK8hBBBKJJSA///UKJdb6jHFTKMWM6kr2VEp+FErdo+ltkCLZGMomaSGy636C5LENsnrTs/u9SuiaMfANAhM65xd25xiptwmpIeabWp3UF8Tb53ehzdVUinBPFNdzV9knEOXw6sVzkLYzFj0Duea7XM9bq5CBu0SYpnJJLJa+WtSYvRO9Bt0ml+QlZLUqYztNxuzKzwmr7K2IbmBrMt7XCsvwJwXBeDxeb3ea+NW5+Q1nv0PDq0rSuxCExOkXocPEPfw51CoxPnxPa49oMe1m76ogBvM5meCmsqyZeVl46ZinSBOhxqH9Q6DfuVbiFuFsmmoW6WVrpXTdu1oL3qA9T0M7hp6go0t46uK3mNg2vmZCv62O8fzfuABkiDwXiC1gZnnZ8v5yeUTxU+jvjum75zTXnLq60Wvbd9WMdCwHowfcnK5KkpoZZS0fLBvw7a+L4+2dq9ZCyITP1+f7u3Zv/971BCY8VbJO2fmdIWPPTm445uBCSdAe2fvQx/O2Lzp7jPvznpc7jYm7Yq2jVl3qGfvZHzgo3Vffecet/JNre700z88UQGO1Z7M1h7+bGMNvI9fcWbwntMnMoP3/7T5jQef39nwyK4pR2vx1qqqP+ue6+hXj9cs+bjppdr6Cb82xKYv/GT2ke0rfo9MmnMkAA+8/cXGg57jjyUXvdf/yxS86fbIlkN/73n/gXl/aXvXHa4/i+c2bjg4aeuYgf7Va08ObiXLX40/u36ftDuWrpmbeX3PlN8Gzn67ZL9beyW3Ztkz/X/EUi++sDvyVC64UQpvMLpf3vLzyVs68un7BwVllqIaDwAA"
    }
    
    private var urlSession: URLSession {
        let authString = "Bearer \(token)"
        let config = URLSessionConfiguration.default
            config.httpAdditionalHeaders = ["Authorization" : authString]
        return URLSession(configuration: config)
    }
    
    func requestData(forUrl url: URL, completion: @escaping (RequestRespnse, Model?) -> ()) {
        DispatchQueue.global(qos: .userInteractive).async { [urlSession = self.urlSession] in
            let task = urlSession.dataTask(with: url) {
                (dataObj, respnse, error) in
                guard       error == nil,
                        let data = dataObj else { return completion(.error(error?.localizedDescription ?? ""), nil)  }
                DispatchQueue.main.async {
                    completion(.success("Successfully Requested Data"), self.decode(data: data))
                }
            }
            task.resume()
        }
    }
    
    func decode(data: Data) -> Model? {
        do {
            return try JSONDecoder().decode(Model.self, from: data)
        } catch let error {
            print("Error Decoding: \(error.localizedDescription)")
            return nil
        }
    }
}
