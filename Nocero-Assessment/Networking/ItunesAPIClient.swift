//
//  ItunesAPIClient.swift
//  Nocero-Assessment
//
//  Created by Dung Kim Nguyen on 07/14/21.
//  Copyright © 2021 Dung Kim Nguyen. All rights reserved.
//

import Foundation

class ItunesAPIClient {
    let downloader = JSONDownloader()
    
    func searchForArtists(withTerm term: String, completion: @escaping ([Artist], ItunesError?) -> Void) {
        let endpoint = Itunes.search(term: term, media: .music(entity: .musicArtist, attribute: .artistTerm))
        
        performRequest(with: endpoint) { results, error in
            guard let results = results else {
                completion([], error)
                return
            }
            
            let artists = results.compactMap { Artist(json: $0) }
            
            completion(artists, nil)
        }
    }
    
    func lookupArtist(withId id: Int, completion: @escaping (Artist?, ItunesError?) -> Void) {
        let endpoint = Itunes.lookup(id: id, entity: MusicEntity.album)
        
        performRequest(with: endpoint) { results, error in
            guard let results = results else {
                completion(nil, error)
                return
            }
            
            guard let artistInfo = results.first else {
                completion(nil, .jsonParsingFailure(message: "Results do not contain artist info."))
                return
            }
            
            guard let artist = Artist(json: artistInfo) else {
                completion(nil, .jsonParsingFailure(message: ("Could not parse artist info.")))
                return
            }
            
            let albumResults = results[1..<results.count]
            let albums = albumResults.compactMap { Album(json: $0) }
            
            artist.albums = albums
            completion(artist, nil)
        }
    }
    
    func lookupAlbum(withId id: Int, completion: @escaping (Album?, ItunesError?) -> Void) {
        let endpoint = Itunes.lookup(id: id, entity: MusicEntity.song)
        
        performRequest(with: endpoint) { results, error in
            guard let results = results else {
                completion(nil, error)
                return
            }
            
            guard let albumInfo = results.first else {
                completion(nil, .jsonParsingFailure(message: "Results do not contain album info."))
                return
            }
            
            guard let album = Album(json: albumInfo) else {
                completion(nil, .jsonParsingFailure(message: ("Could not parse album info.")))
                return
            }
            
            let songResults = results[1..<results.count]
            let songs = songResults.compactMap { Song(json: $0) }
            
            album.songs = songs
            completion(album, nil)
        }
    }
    
    typealias Results = [[String: Any]]
    
    private func performRequest(with endpoint: Endpoint, completion: @escaping (Results?, ItunesError?) -> Void) {
        
        let task = downloader.jsonTask(with: endpoint.request) { json, error in
            DispatchQueue.main.async {
                guard let json = json else {
                    completion(nil, error)
                    return
                }
                
                guard let results = json["results"] as? [[String: Any]] else {
                    completion(nil, .jsonParsingFailure(message: "JSON data does not contain results."))
                    return
                }
                
                completion(results, nil)
            }
        }
        
        task.resume()
    }
}
