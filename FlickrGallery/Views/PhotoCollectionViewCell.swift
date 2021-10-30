//
//  PhotoCollectionViewCell.swift
//  FlickrGallery
//
//  Created by Gabriel Medeiros Pelegrino on 30/10/2021.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var photoImageView: UIImageView!
    
    func populate(photo: FlickrPhoto){
                
        photoImageView.setImageWithUrl(url: photo.url_s)
    }
}
