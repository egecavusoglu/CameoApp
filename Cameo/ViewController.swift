//
//  ViewController.swift
//  Cameo
//
//  Created by Ege Çavuşoğlu on 10/26/20.
//  Copyright © 2020 Ege Çavuşoğlu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate, UICollectionViewDataSource {

    var movies: [Movie]?
    @IBOutlet weak var searchBar: UISearchBar!
    var searchTask: DispatchWorkItem?
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchBar.delegate = self
//        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func searchMovies(query: String){
        DispatchQueue.main.async{
            if let results = getMovies(query: query) {
                self.movies = results
                self.collectionView.reloadData()
            }
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
    
    
}

