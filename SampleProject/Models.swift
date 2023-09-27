//
//  Models.swift
//  SampleProject
//
//  Created by Abir on 24/9/23.
//

import Foundation

struct Photos: Decodable{
    let albumId: Int
    let id: Int
    let url: String
    let thumbnailUrl: String
}


struct Album: Decodable{
    let userId: Int
    let id: Int
    let title: String
}

class MyData{
    var photos:[Photos] = []
    var albums:[Album] = []
    
    static let shared = MyData()
    
    private init() {
        
    }
}
