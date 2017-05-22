//
//  ImagesDataDB.swift
//  DribbleTest
//
//  Created by Аметов Асан on 19.05.17.
//  Copyright © 2017 Asan Ametov. All rights reserved.
//

import UIKit
import Realm

class ImagesDataDB: RLMObject {
    var hidpi: String!
    var normal: String!
    var teaser: String!
}
