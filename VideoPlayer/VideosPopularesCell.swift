//
//  VideosPopularesCell.swift
//  VideoPlayer
//
//  Created by Marco Alonso Rodriguez on 06/05/23.
//

import Foundation
import UIKit
import Kingfisher

class VideosPopularesCell: UICollectionViewCell {
    
    
    @IBOutlet weak var videoPopularImage: UIImageView!
    
    func setupCell(url: String) {
        
        if let url = URL(string: url) {
            videoPopularImage.kf.setImage(with: url)
            videoPopularImage.layer.cornerRadius = 18
        }
        
    }
}
