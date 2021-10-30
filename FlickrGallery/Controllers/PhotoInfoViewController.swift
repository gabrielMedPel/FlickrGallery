//
//  PhotoInfoViewController.swift
//  FlickrGallery
//
//  Created by Gabriel Medeiros Pelegrino on 30/10/2021.
//

import UIKit

class PhotoInfoViewController: UIViewController {
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var photoInfo: FlickrPhoto?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.titleView?.tintColor = .white
        
        fillInfo()
    }
    
    func fillInfo(){
        guard let photoInfo = photoInfo else {
            return
        }

        photoImageView.setImageWithUrl(url: photoInfo.url_s)
        titleLabel.text = photoInfo.title
        
    }
    


}
