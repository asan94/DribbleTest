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
            shots.removeAll()
            Alamofire.request(request).responseJSON() {json in
                guard json.error == nil else {
                    self.shots = self.dbManager.getShots()
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: Constants.getShotsFailure), object: json.error)
                    return
                }
                if let jsonr = json.result.value {
                    let jsonToMap: [[String: Any]] = (jsonr as? [[String:Any]])!
                    for dic in jsonToMap {
                        if let parsedObject = Mapper<Shots>(context: nil).map(JSON: dic) {
                            if parsedObject.animated == false && self.shots.count < 50{
                                self.shots.append(parsedObject)
                            }
                        }
                    }
                    self.dbManager.saveShot(shots: self.shots)
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: Constants.getShotsSuccess), object: nil)
                }
            }
        }
        catch _ {
            
        }
    }
    func getShotsCount() -> Int {
        return shots.count
    }
    func getShotForIndex(index: Int) -> Shots {
        return self.shots[index]
    }
    
}
