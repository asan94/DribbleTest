//
//  ShotsDB.swift
//  DribbleTest
//
//  Created by Аметов Асан on 19.05.17.
//  Copyright © 2017 Asan Ametov. All rights reserved.
//

import UIKit
import RealmSwift

class ShotDB: Object {
    var ID = RealmOptional<Int>()
    dynamic var title: String! = nil
    dynamic var Description: String! = nil
    var width = RealmOptional<Int>()
    var height = RealmOptional<Int>()
    var animated = RealmOptional<Bool>()
    dynamic var imageHidpi: String! = nil
    dynamic var imageNormal: String! = nil
    dynamic var imageTeaser: String! = nil
}

