//
//  ItunesClient.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 22.01.2022.
//

import Foundation

class ItunesClient{
    
    func searchForName (for searchKey : String ,completion : @escaping(Result<[UnHandleData]? , DownloadError>) -> Void) -> Void{

        let urlSearchKey = searchKey.replacingOccurrences(of: " ", with: "+")
        
        guard let url = URL(string: "https://itunes.apple.com/search?term=\(urlSearchKey)&limit=1&entity=song&sort=recent&country=TR")else{
            return completion(.failure(.wrongUrl))
        }

        URLSession.shared.dataTask(with: url) { data, response, errors in
            guard let data = data else {
                return completion(.failure(.unload))
            }
            guard let finalResult = try? JSONDecoder().decode(SearchData.self,from:data) else{
                return completion(.failure(.unbuild))
            }
            completion(.success(finalResult.results))
        }.resume()

    }
    
    
    func detailForID (for songID : Double, completion : @escaping(Result<UnHandleData? , DownloadError>) -> Void) -> Void{
        guard let url = URL(string:"https://itunes.apple.com/lookup?id=\(Int(songID))&entity=song&country=TR")else{
            return completion(.failure(.wrongUrl))
        }
        
        URLSession.shared.dataTask(with: url) { data, response, errors in
            guard let data = data else {
                return completion(.failure(.unload))
            }
            guard let finalResult = try? JSONDecoder().decode(SearchData.self,from:data) else{
                return completion(.failure(.unbuild))
            }
            completion(.success(finalResult.results![0]))
        }.resume()
    }
}

enum DownloadError : Error {
    case wrongUrl
    case unload
    case unbuild
}
