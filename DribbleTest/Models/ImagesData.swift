//
//  ImagesData.swift
//  DribbleTest
//
//  Created by Аметов Асан on 19.05.17.
//  Copyright © 2017 Asan Ametov. All rights reserved.
//

import UIKit
import ObjectMapper

class ImagesData: NSObject, Mappable{
    var hidpi: String!
    var normal: String!
    var teaser: String!
    override init() {
        
    }
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        hidpi  <- map["hidpi"]
        normal <- map["normal"]
        teaser <- map["teaser"]
    }
    
}
