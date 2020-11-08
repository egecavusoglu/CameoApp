//
//  ViewController.swift
//  Cameo
//
//  Created by Ege Çavuşoğlu on 10/26/20.
//  Copyright © 2020 Ege Çavuşoğlu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate, UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let theUser = User.shared
    
    // Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var logButton: UIBarButtonItem!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    
    // Class member vars
    var movies: [Movie]?
    var movieDetails: Movie?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchBar.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.keyboardDismissMode = .onDrag
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        spinner.isHidden = true

    }
    
    
    func searchMovies(query: String){
        
        DispatchQueue.main.async{
            self.spinner.isHidden = false
            self.spinner.startAnimating()
            if let results = getMovies(query: query) {
                self.movies = results
                self.collectionView.reloadData()
                
            }
            self.spinner.stopAnimating()
            self.spinner.isHidden = true
        }
        
    }
    
    func searchBar(_: UISearchBar, textDidChange: String){
        guard let query = searchBar!.text else {
            return
        }
        searchMovies(query: query)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movie = movies?[indexPath.row]
        if let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as? MovieCell {
            cell.imageURL = movie?.poster_path
            cell.label.text = movie?.title
            return cell
        }
        else {
            return UICollectionViewCell()
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (self.view.frame.width - 70.0) / 2
        let height: CGFloat = (width / 2) * 3
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        movieDetails = movies?[indexPath.row]
        performSegue(withIdentifier: "goToDetails", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetails" {
            let detailsVc = segue.destination as! DetailsVC
            detailsVc.movie = movieDetails
        }
    }
    
    
    @IBAction func logUserIn(_ sender: Any) {
        performSegue(withIdentifier: "signinModal", sender: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let configuration = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { actions -> UIMenu? in
            let action = UIAction(title: "Add to Favorites", image: UIImage(systemName: "star.fill")) { action in
                let movie = self.movies?[indexPath.row]
                let mid = String(movie!.id)
                let res = self.theUser.addToFavorites(name: movie!.title, id: mid)
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
            return UIMenu(title: "Menu", image:nil, children: [action])
        }
        return configuration
    }
    
     
    
    
}

