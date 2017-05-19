//
//  ShotsDomainDBDataMapper.swift
//  DribbleTest
//
//  Created by Аметов Асан on 19.05.17.
//  Copyright © 2017 Asan Ametov. All rights reserved.
//

import UIKit
import RealmSwift
class ShotsDomainDBDataMapper: NSObject {
    func transformShotsDBToArray(shotsDB: Results<ShotDB>) -> [Shots] {
        var shots = [Shots]()
        for shot in shotsDB {
            shots.append(self.transformShotDBToShots(shotDB: shot))
        }
        return shots
    }
    func transformShotToShotsDB(shot:Shots) -> ShotDB {
        let shotDB = ShotDB()
        shotDB.ID = RealmOptional(shot.ID)
        shotDB.title = shot.title
        shotDB.Description = shot.Description
        shotDB.width = RealmOptional(shot.width)
        shotDB.height = RealmOptional(shot.height)
        shotDB.animated = RealmOptional(shot.animated)
        shotDB.imageHidpi = shot.imageHidpi
        shotDB.imageNormal = shot.imageNormal
        shotDB.imageTeaser = shot.imageTeaser
        return shotDB
    }
    func transformImageDataToImagesDataDB(imagesData: ImagesData) -> ImagesDataDB {
        let imagesDataDB = ImagesDataDB()
        imagesDataDB.hidpi = imagesData.hidpi
        imagesDataDB.normal = imagesData.normal
        imagesDataDB.teaser = imagesData.teaser
        return imagesDataDB
    }
    func transformShotDBToShots(shotDB:ShotDB) -> Shots {
        let shot = Shots()
        shot.ID = shotDB.ID.value
        shot.title = shotDB.title
        shot.Description = shotDB.Description
        shot.width = shotDB.width.value
        shot.height = shotDB.height.value
        shot.animated = shotDB.animated.value
        shot.imageHidpi = shotDB.imageHidpi
        shot.imageNormal = shotDB.imageNormal
        shot.imageTeaser = shotDB.imageTeaser
        return shot
    }
    func transformImageDataDBToImageData(imagesDataDB: ImagesDataDB) -> ImagesData {
        let imageData = ImagesData()
        imageData.hidpi = imagesDataDB.hidpi
        imageData.normal = imagesDataDB.normal
        imageData.teaser = imagesDataDB.teaser
        return imageData
    }
}
