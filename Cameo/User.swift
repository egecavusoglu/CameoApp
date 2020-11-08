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
    var username: String?
    var favorites: [Movie]?
    
    
    init() {
        loggedIn = false
    }
    
    func logIn(uid: String){
        loggedIn = true
    }
    
    func logOut(){
        loggedIn = false
    }
    
    
    //     TODO
    //    1. Fetch User favorites.
    //    2. Add favorites.
}
