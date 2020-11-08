//
//  User.swift
//  Cameo
//
//  Created by Ege Çavuşoğlu on 11/8/20.
//  Copyright © 2020 Ege Çavuşoğlu. All rights reserved.
//

import Foundation

class User {
    
    static let shared = User()
    
    var loggedIn: Bool
    var id: String?
    
    var favorites: [Movie]?
    
    
    init() {
        loggedIn = false
    }
    
    func updateInfo(uid: String){
        loggedIn = true
        id = uid
        print("INFO UPDATED \(uid)")
    }
    
    func logOut(){
        loggedIn = false
        id = nil
        print("USER EMPTIED")

    }
    
    func addToFavorites(){
        
    }
    
    func getFavorites(){
        
    }
    
    
    //     TODO
    //    1. Fetch User favorites.
    //    2. Add favorites.
}
