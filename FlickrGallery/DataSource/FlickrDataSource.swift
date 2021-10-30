//
//  FlickrDataSource.swift
//  FlickrGallery
//
//  Created by Gabriel Medeiros Pelegrino on 30/10/2021.
//

import Foundation

//https://api.flickr.com/services/rest/?method=flickr.photos.getRecent&extras=url_s&format=json&nojsoncallback=1&api_key=aabca25d8cd75f676d3a74a72dcebf21

//https://live.staticflickr.com/{server-id}/{id}_{secret}_{size-suffix}.jpg


struct FlickrDataSource {
    let baseUrl = "https://api.flickr.com"
    let baseUrlPhoto = "https://live.staticflickr.com"
    let apiKey = "aabca25d8cd75f676d3a74a72dcebf21"
    
    
    
    func getRecentPhotos(pageNumber: Int, callback: @escaping (FlickrPhotosResponse?, FlickrError?)->Void) {
        
        guard let url = URL(string: "\(baseUrl)/services/rest/?method=flickr.photos.getRecent&extras=url_s&format=json&nojsoncallback=1&page=\(pageNumber)&api_key=\(apiKey)")else {
            DispatchQueue.main.async {callback(nil, .urlError)}
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { (data, response, err) in
            if let err = err{
                DispatchQueue.main.async {callback(nil, .serverAccessError(cause: err))}
                return
            }
            
            guard let res = response as? HTTPURLResponse else {
                DispatchQueue.main.async {callback(nil, .notHttpRequest)}
                return
            }
            
            guard (200...299).contains(res.statusCode) else{
                DispatchQueue.main.async {callback(nil, .httpError(statusCode: res.statusCode))}
                return
            }
            
            guard let data = data else{
                DispatchQueue.main.async {callback(nil, .noData)}
                return
            }
            
            do{
                let decoder = JSONDecoder()
//                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let photoInfo = try decoder.decode(FlickrPhotosResponse.self, from: data)
                DispatchQueue.main.async {callback(photoInfo, nil)}
                
            }catch let err{
                DispatchQueue.main.async {callback(nil, .jsonDecodingError(cause: err))}
            }
            
            }.resume()
    }
    
    enum FlickrError:Error {
        case urlError
        case serverAccessError(cause: Error)
        case httpError(statusCode: Int)
        case notHttpRequest
        case noData
        case jsonDecodingError(cause: Error)
        
    }
}
