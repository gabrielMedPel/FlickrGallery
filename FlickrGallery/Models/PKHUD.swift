//
//  PKHUD.swift
//  FlickrGallery
//
//  Created by Gabriel Medeiros Pelegrino on 30/10/2021.
//

import PKHUD

protocol ShowHUD{}
extension ShowHUD{
    func showProgress(title:String, subtitle: String? = nil){
        HUD.show(.labeledProgress(title: title, subtitle: subtitle))
    }
    
    func showError(title:String, subtitle: String? = nil){
        HUD.flash(.labeledError(title: title, subtitle: subtitle), delay: 1.5)
    }
    
    func showLabel(title:String){
        HUD.flash(.label(title), delay: 3)
    }
    
    func showSuccess(title:String, subtitle: String? = nil){
        HUD.flash(.labeledSuccess(title: title, subtitle: subtitle) ,delay: 1.5)
    }
}
extension UIViewController: ShowHUD{}
