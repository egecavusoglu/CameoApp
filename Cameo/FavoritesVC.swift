//
//  FavoritesVC.swift
//  Cameo
//
//  Created by Ege Çavuşoğlu on 10/26/20.
//  Copyright © 2020 Ege Çavuşoğlu. All rights reserved.
//

import UIKit
import FirebaseDatabase

class FavoritesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // Global vars setup
    var ref = Database.database().reference()
    let theUser = User.shared
    
    // Member vars
    var favorites:[[String: String]] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.keyboardDismissMode = .onDrag
        getFavorites()
    }
    
    func getFavorites(){
        if (getLoginStatus()){
            ref.child("/users/\(getUserId())/favorites/").observe(.value) { (snap) in
                self.favorites = []
                if let favs = snap.value as? [String: [String: String]] {
                    for (k, v) in favs {
//                        print("MOVIE \(k)")
//                        print("VAL \(v["name"]!)")
                        self.favorites.append(["name": v["name"]!, "movieId": v["id"]!])
                    }
                    self.tableView.reloadData()
                }
                
            }
        }
        else{
            //            User is not logged in
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "favCell")
        
        cell.textLabel!.text = favorites[indexPath.row]["name"]!
        
        return cell
    }
    
    
    
    
    
    
}
