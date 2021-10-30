//
//  FlickrPhoto.swift
//  FlickrGallery
//
//  Created by Gabriel Medeiros Pelegrino on 30/10/2021.
//

import Foundation

struct FlickrPhotosResponse: Codable {
    let photos: Photos
}

struct Photos: Codable{
    var page: Int = 0
    var pages: Int = 0
    var perpage: Int = 0
    var total: Int = 0
    let photo: [FlickrPhoto]
}

struct FlickrPhoto: Codable {
    let id: String
    let owner: String
    let secret: String
    let server: String
    var farm: Int = 0
    let title: String
    var ispublic: Int = 0
    var isfriend: Int = 0
    var isfamily: Int = 0
    var url_s: String?
    var height_s: Int = 0
    var width_s: Int = 0
    
    
    enum CodingKeys: String, CodingKey {
        case id, owner, secret, server, title, url_s
    }
}


