//
//  ImageEx.swift
//  ShowerTemp
//
//  Created by Nikhil on 3/27/17.
//  Copyright © 2017 Nikhil. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    func loadImageUsingCacheWithUrlString(urlString: String){
        
        //if there is a chached image it uses that or else it downloads it in the next method 
        if let cachedImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage{
            self.image = cachedImage
            return
        }
        
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if(error != nil){
                print(error!)
                return
            }
            DispatchQueue.main.async {
                if let downloadImage = UIImage(data: data!){
                    imageCache.setObject(downloadImage, forKey: urlString as AnyObject)
                self.image = downloadImage
                }
            }
            
        }).resume()
    }
}
