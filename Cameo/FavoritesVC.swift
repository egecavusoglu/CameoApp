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
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var labelHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if(getLoginStatus()){
            tableView.isHidden = false
            labelHeight.constant = 0
            getFavorites()
        }
        else{
            tableView.isHidden = true
            labelHeight.constant = 25
        }
    }
    
    func getFavorites(){
        if (getLoginStatus()){
            ref.child("/users/\(getUserId())/favorites/").observe(.value) { (snap) in
                var newArr:[[String: String]]  = []
                if let favs = snap.value as? [String: [String: String]] {
                    for (_, v) in favs {
                        newArr.append(["name": v["name"]!, "movieId": v["id"]!])
                    }
                    self.favorites = newArr
                    self.tableView.reloadData()
                }
                else{
                    self.favorites = []
                    self.tableView.reloadData()
                }
                
            }
        }
        else{
            self.favorites = []
            self.tableView.reloadData()
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let movieName = favorites[indexPath.row]["name"]!
        let res = theUser.removeFavorite(name: movieName)
    }
    
    
    
    
    
    
}
