//
//  Shots.swift
//  DribbleTest
//
//  Created by Аметов Асан on 19.05.17.
//  Copyright © 2017 Asan Ametov. All rights reserved.
//

import UIKit
import ObjectMapper

class Shots: NSObject, Mappable {
    var ID: CLong!
    var title: String!
    var Description: String!
    var width: Int!
    var height: Int!
    var animated: Bool!
    var imageHidpi: String!
    var imageNormal: String!
    var imageTeaser: String!
    override init() {
        
    }
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        ID  <- map["id"]
        title <- map["title"]
        Description <- map["description"]
        width <- map["width"]
        height <- map["height"]
        animated <- map["animated"]
        imageHidpi <- map["images.hidpi"]
        imageNormal <- map["images.normal"]
        imageTeaser <- map["images.teaser"]
        
    }
}

