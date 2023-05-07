//
//  PopularVideosModel.swift
//  VideoPlayer
//
//  Created by Marco Alonso Rodriguez on 06/05/23.
//

import Foundation

struct PopularVideosModel: Codable {
    let videos: [VideoPopular]
}

struct VideoPopular: Codable {
    let url: String
    let image: String
    let video_files: [VideoFiles]
}

struct VideoFiles: Codable {
    let link: String
}
