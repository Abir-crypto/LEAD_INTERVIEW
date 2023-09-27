//
//  DataParser.swift
//  SampleProject
//
//  Created by Abir on 24/9/23.
//

import Foundation

final class DataParser{
    
    private let photoUrl = "https://jsonplaceholder.typicode.com/photos"
    private let albumUrl = "https://jsonplaceholder.typicode.com/albums"
    static let shared = DataParser()
    
    private init(){
        
    }
    
    func getAllPhotos(completion: @escaping () -> ()){
        if let url = URL(string: photoUrl) {
            URLSession.shared.dataTask(with: url){ data, response, error in
                if let data = data{
                    do{
                        let res = try JSONDecoder().decode([Photos].self, from: data)
                        print("000 \(res)")
                        MyData.shared.photos = res
                        completion()
                    }
                    catch{
                        debugPrint(error.localizedDescription)
                    }
                }
            }.resume()
        }
    }
    
    func getAllAlbums(completion: @escaping () -> ()){
        if let url = URL(string: albumUrl) {
            URLSession.shared.dataTask(with: url){ data, response, error in
                if let data = data{
                    do{
                        let res = try JSONDecoder().decode([Album].self, from: data)
                        print("000 \(res)")
                        MyData.shared.albums = res
                        completion()
                    }
                    catch{
                        debugPrint(error.localizedDescription)
                    }
                }
            }.resume()
        }
    }
}
