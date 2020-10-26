//
//  MovieCell.swift
//  Cameo
//
//  Created by Ege Çavuşoğlu on 10/26/20.
//  Copyright © 2020 Ege Çavuşoğlu. All rights reserved.
//

import UIKit

//struct MovieCell {
//    let image: UIImage
//    let name: String
//}

class MovieCell: UICollectionViewCell {
    
    var imageURL : String? {
        didSet {
            DispatchQueue.global(qos: .background).async {
                let baseURL = "https://image.tmdb.org/t/p/w185"
                if (self.imageURL == nil){
                    return
                }
                guard let url = URL(string: "\(baseURL + self.imageURL!)") else{
                    return
                }
                guard let data = try? Data(contentsOf: url) else {
                    return
                }
                
                guard let imageData = try? UIImage(data: data) else {
                    return
                }
                DispatchQueue.main.sync{
                    self.imageView.image = imageData
                }
                
            }
            
        }
    }
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
}
