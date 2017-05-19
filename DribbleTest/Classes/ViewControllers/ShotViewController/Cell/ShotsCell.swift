//
//  ShotsCell.swift
//  DribbleTest
//
//  Created by Аметов Асан on 19.05.17.
//  Copyright © 2017 Asan Ametov. All rights reserved.
//

import UIKit
import SDWebImage

class ShotsCell: UITableViewCell {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var shotsImageView: UIImageView!
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
            layer.borderWidth = 0.5
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func setupWithShot(shot:Shots) {
        titleLabel.text = shot.title
        if shot.Description != nil {
            descriptionLabel.text = shot.Description.stripHTML()
        }
        if shot.imageHidpi != nil {
            shotsImageView.sd_setImage(with: URL(string:shot.imageHidpi))
        } else if shot.imageNormal != nil {
            shotsImageView.sd_setImage(with: URL(string:shot.imageNormal))
        } else {
            shotsImageView.sd_setImage(with: URL(string:shot.imageTeaser))
        }
        shotsImageView.setIndicatorStyle(.gray)
        shotsImageView.setShowActivityIndicator(true)
    }
    
}
