//
//  NetworkManager.swift
//  DribbleTest
//
//  Created by Аметов Асан on 19.05.17.
//  Copyright © 2017 Asan Ametov. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class NetworkManager: NSObject {
    func getURLRequest() throws -> URLRequest {
        let urlString: String = ConstantsAPI.kBaseUrl + ConstantsAPI.kShots
        let url = URL(string:urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let authValue = Constants.clientAccessToken
        let headers: [String: String] = [
            "Content-Type": "application/json",
            "Authorization": authValue
        ]
        request.timeoutInterval = 15
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
        let params: [String: Any] = ["page": 0, "sort": "comments", "per_page": 100]
        
        return try! URLEncoding.queryString.encode(request, with: params)
    }
}

