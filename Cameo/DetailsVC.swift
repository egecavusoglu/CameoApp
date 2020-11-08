//
//  DetailsVC.swift
//  Cameo
//
//  Created by Ege Çavuşoğlu on 10/26/20.
//  Copyright © 2020 Ege Çavuşoğlu. All rights reserved.
//

import UIKit
import Firebase


class DetailsVC: UIViewController {
    var movie: Movie?
    
    
    @IBOutlet weak var imageView: UIView!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var backdropImage: UIImageView!
    @IBOutlet weak var overview: UILabel!
    @IBOutlet weak var addFavoriteButton: UIButton!
    @IBOutlet weak var originalTitle: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var releaseDate: UILabel!

    var theUser = User.shared

    
    override func viewDidLoad() {
        super.viewDidLoad()
        addFavoriteButton.layer.cornerRadius = 8
        navigationItem.title = movie?.title
        overview.text = movie?.overview
        originalTitle.text = movie?.original_title
        rating.text = String(format: "%.2f", movie?.vote_average as! CVarArg)
        releaseDate.text = handleDate(Date: movie?.release_date ?? "")
        
        // Spinner code snippet taken from https://www.hackingwithswift.com/example-code/uikit/how-to-use-uiactivityindicatorview-to-show-a-spinner-when-work-is-happening
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        imageView.addSubview(spinner)
        spinner.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
    
        renderPhotos(poster: movie?.poster_path ?? "", backdrop: movie?.backdrop_path ?? "")
        spinner.removeFromSuperview()
        
        
        
    }
    
    // Inspired by https://stackoverflow.com/questions/35700281/date-format-in-swift
    func handleDate(Date: String) -> String?{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"
        if let date = dateFormatterGet.date(from: Date) {
            return dateFormatterPrint.string(from: date)
        } else {
           return nil
        }
    }
    
    func renderPhotos(poster: String, backdrop: String){
        DispatchQueue.global(qos: .background).async {
            let p = fetchPoster(path: poster) ?? UIImage()
            let b = fetchBackdrop(path: backdrop) ?? UIImage()
            DispatchQueue.main.async{
                self.posterImage.image = p
                self.backdropImage.image = b
            }
        }
    }
    
    
    @IBAction func addFavorite(_ sender: Any) {
        let movieId:String = String((movie?.id)!)
        let res = theUser.addToFavorites(name: movie!.title, id: movieId)
        if (!res){
            let alert = UIAlertController(title: "Oops!", message: "Make sure you are signed in before saving favorites.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        else{
            let alert = UIAlertController(title: "Success", message: "Movie is saved to favorites.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        
    }
    
}

