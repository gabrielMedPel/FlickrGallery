//
//  UIImageView+extensions.swift
//  FlickrGallery
//
//  Created by Gabriel Medeiros Pelegrino on 30/10/2021.
//

import UIKit
import SDWebImage

extension UIImageView{
    func setImageWithUrl(url: String?) {
        guard let urlStr = url else {return}
        guard let url = URL(string: urlStr) else {return}
        
        self.sd_setImage(with: url) { (image, error, cacheTyoe, url) in
            if let error = error{
                print(error)
            }
        }
    }
}

