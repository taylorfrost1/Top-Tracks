//
//  DataStore.swift
//  TopTracksApp
//
//  Created by Taylor Frost on 6/20/16.
//  Copyright © 2016 Taylor Frost. All rights reserved.
//

import UIKit

// DataStore will hold all of our artists and arrays for the app

class DataStore: NSObject {
    
    //Make this a singleton
    
    static let sharedInstance = DataStore()
    override private init() {} // This prevents any additional objects from being created
    
    var artistsArray = [Artist]()
    var tracksArray = [Track]()
    var albumsArray = [Album]()
    var artistRArray = [Artist]()
    
    func addArtist(theArtist: Artist) {
        self.artistsArray.append(theArtist)
    }
    
    func addTrack(theTrack: Track){
        self.tracksArray.append(theTrack)
    }
    
    func addAlbum(theAlbum: Album){
        self.albumsArray.append(theAlbum)
    }
    
    func addRelatedArtist(theRArtist: Artist){
        self.artistRArray.append(theRArtist)
    }
    
}
