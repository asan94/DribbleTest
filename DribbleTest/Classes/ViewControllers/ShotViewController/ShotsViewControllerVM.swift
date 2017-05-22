//
//  ShotsViewControllerVM.swift
//  DribbleTest
//
//  Created by Аметов Асан on 19.05.17.
//  Copyright © 2017 Asan Ametov. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

class ShotsViewControllerVM: NSObject {
    let manager = NetworkManager()
    let dbManager = DataManager()
    var shots = [Shots]()
    func getShotss() -> Void {
        let manager = NetworkManager()
        do {
            let request:URLRequest =  try manager.getURLRequest()
            Alamofire.request(request).responseJSON() {json in
                self.shots.removeAll()
                guard json.error == nil else {
                    self.shots = self.dbManager.getShots()
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: Constants.getShotsFailure), object: json.error)
                    return
                }
                if (json.result.value != nil) {
                    self.shots = self.getObjectWithJSONResult(jsonResult: json.result)
                    self.dbManager.saveShot(shots: self.shots)
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: Constants.getShotsSuccess), object: nil)
                }
            }
        }
        catch _ {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: Constants.getShotsFailure), object: self.getRequestError())
        }
    }
    private func getRequestError() -> NSError {
        let userInfo: [AnyHashable : Any] = [NSLocalizedDescriptionKey : NSLocalizedString("Error", value: "Сервер недоступен", comment: "") ,NSLocalizedFailureReasonErrorKey : NSLocalizedString("Error", value: "Сервер недоступен", comment: "")
            ]
        let error = NSError(domain: "ru.dribbleTest.app", code: -20, userInfo: userInfo)
        return error
    }
    private func getObjectWithJSONResult(jsonResult: Result<Any>) -> [Shots] {
        var shotsArray = [Shots]()
        if let jsonr = jsonResult.value {
            let jsonToMap: [[String: Any]] = (jsonr as? [[String:Any]])!
            for dic in jsonToMap {
                if let parsedObject = Mapper<Shots>(context: nil).map(JSON: dic) {
                    if parsedObject.animated == false && self.shots.count < 50{
                        shotsArray.append(parsedObject)
                    }
                }
            }
        }
        return shotsArray
    }
    
    func getShotsCount() -> Int {
        return shots.count
    }
    func getShotForIndex(index: Int) -> Shots {
        return self.shots[index]
    }
    
}
