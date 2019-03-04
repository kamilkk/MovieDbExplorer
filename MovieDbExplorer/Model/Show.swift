//
//  Show.swift
//  MovieDbExplorer
//
//  Created by Kamil Kowalski on 03/03/2019.
//  Copyright © 2019 Kamil Kowalski. All rights reserved.
//

struct Show: Decodable {
    let id: Int
    let name: String
    let posterUrl: String
    let releaseDate: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, posterUrl = "poster_path", releaseDate = "first_air_date"
    }
}
