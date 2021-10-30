//
//  ViewController.swift
//  FlickrGallery
//
//  Created by Gabriel Medeiros Pelegrino on 30/10/2021.
//

import UIKit

class ViewController: UIViewController {
    var photos:[FlickrPhoto] = []
    var isLoaded = false
    var pageNumber = 1
    
    var isLoadingList : Bool = false
    
    
    
    @IBOutlet weak var photosCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showProgress(title: "")
        photos = []
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if !isLoaded{
            getPhotos(pageNumber: pageNumber)
        }
        photosCollectionView.indexPathsForSelectedItems?.forEach({ indexPath in
            photosCollectionView.deselectItem(at: indexPath, animated: false)
        })
    }
    
    func loadMoreItemsForList(){
        pageNumber += 1
        getPhotos(pageNumber: pageNumber)
    }
    
    func getPhotos(pageNumber: Int){
        self.isLoadingList = false
        
        let ds = FlickrDataSource()
        ds.getRecentPhotos(pageNumber: pageNumber) { [weak self](photoInfo, err) in
            if err != nil{
                print(err!)
            }
            
            if let photos = photoInfo?.photos.photo{
                DispatchQueue.main.async {
                    self?.photos.append(contentsOf: photos)
                    self?.photosCollectionView.reloadData()
                    if !(self?.isLoaded ?? false){
                        self?.showSuccess(title: "")
                    }
                    self?.isLoaded = true
                    
                }
                
            }
            
        }
    }
    
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        if let cell = cell as? PhotoCollectionViewCell{
            let photo = photos[indexPath.row]
            
            cell.populate(photo: photo)
        }
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
           if (((scrollView.contentOffset.y + scrollView.frame.size.height) > scrollView.contentSize.height ) && !isLoadingList){
               self.isLoadingList = true
               self.loadMoreItemsForList()
           }
       }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toPhotoInfo", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        if let dest = segue.destination as? PhotoInfoViewController{
            dest.photoInfo = photos[(photosCollectionView.indexPathsForSelectedItems?.first!.item)!]
        }
        
    }

    
   
    
    
    
}


