//
//  Models.swift
//  Cameo
//
//  Created by Ege Çavuşoğlu on 10/26/20.
//  Copyright © 2020 Ege Çavuşoğlu. All rights reserved.
//

import Foundation

struct APIResults:Decodable {
    let page: Int
    let total_results: Int
    let total_pages: Int
    let results: [Movie]
}

struct Movie: Decodable {
    let id: Int!
    let poster_path: String?
    let title: String
    let release_date: String
    let vote_average: Double
    let overview: String
    let vote_count:Int!
}

let API_KEY = "18127daabad472c4074e6de4ea82b19f"

    
    func getRequest(url: String){
        
    }
    
    func getMovies(query: String) -> [Movie]?{
        let urlString = "https://api.themoviedb.org/3/search/movie?api_key=\(API_KEY)&query=\(query)"
        guard let url = try? URL(string: urlString) else {
            return nil
        }
        guard let data = try? Data(contentsOf: url) else {
            return nil
        }
        guard let response = try? JSONDecoder().decode(APIResults.self, from: data)  else {
            return nil
        }
        return response.results
        
    }
    
    func postRequest(url: String, body: String ){
        
    }

