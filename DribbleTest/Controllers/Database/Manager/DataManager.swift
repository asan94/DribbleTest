//
//  DataManager.swift
//  DribbleTest
//
//  Created by Аметов Асан on 19.05.17.
//  Copyright © 2017 Asan Ametov. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class DataManager: NSObject {
    var shotsDomaintDBDataMapper: ShotsDomainDBDataMapper!
    override init() {
        shotsDomaintDBDataMapper = ShotsDomainDBDataMapper()
    }
    func saveShot(shots:[Shots]) -> Void {
        let realm = try! Realm()
        try! realm.write({
            realm.deleteAll()
        })
        try! realm.write {
            for shot in shots {
                let shotDB: ShotDB = shotsDomaintDBDataMapper.transformShotToShotsDB(shot: shot)
                realm.add(shotDB)
            }
        }
    }
    
    func getShots() -> [Shots] {
        let realm = try! Realm()
        let dbResult = realm.objects(ShotDB.self)// ShotDB.allObjects()
        let shots: [Shots] = shotsDomaintDBDataMapper.transformShotsDBToArray(shotsDB: dbResult)
        return shots
    }
}
