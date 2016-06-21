//
//  APIController.swift
//  TopTracksApp
//
//  Created by Taylor Frost on 6/20/16.
//  Copyright © 2016 Taylor Frost. All rights reserved.
//

import UIKit

class APIController: NSObject {
    
    //Create a session constant
    let session = NSURLSession.sharedSession()
    
    func fetchTopTracks(artistID: String){
        //1. Put URLString from web
        let urlString = "https://api.spotify.com/v1/artists/\(artistID)/top-tracks?country=US"
        
    //print(urlString)
   
    //2. Create url
    if let url = NSURL(string: urlString){
        //3.Create a Data Taask for pulling the data from the url
        
        let task = session.dataTaskWithURL(url, completionHandler: { (data, response, error) in
            
            //4. Check if there is an error
            
            if error != nil {
//                print(error?.localizedDescription)
            }
            
            //5. Parse the JSON
            
            if let jsonDictionary = self.parseJSON(data) {
//                print(jsonDictionary)
                
                if let tracksArray = jsonDictionary["tracks"] as? JSONArray {
//                    print(tracksArray)
                    
                    for tracksDict in tracksArray {
                        
                        let theTrack = Track(dict:tracksDict)
                        print(theTrack.name)
                        print(theTrack.previewURL)
                        
                        DataStore.sharedInstance.addTrack(theTrack)
                        
                }
                    
                } else {
                    
                    print("I could not parse tracks array")
                }
                
                
            } else {
                print("I could not parse the dictionary")
            }
            
            
        })
        task.resume()
    }
    
}
    //Fetch the Artists from the Web API
    
    func fetchArtists(query: String) {
        // 1. Put the URLString for the API Call
        let urlString = "https://api.spotify.com/v1/search?q=\(query)&type=artist"
        //2. Attempt to create a valid NSURL from the string
        if let url = NSURL(string: urlString) {
            
        //3. Create a Data Task for pulling the data from the URL
            
            let task = session.dataTaskWithURL(url, completionHandler: { (data, response, error) in
                
                //4. Check if there is an error
                
                if error != nil {
                    print(error?.localizedDescription)
                    return
                }
                
                if let jsonDictionary = self.parseJSON(data){
//                    print(jsonDictionary)
                    
                    if let artistsDict = jsonDictionary["artists"] as? JSONDictionary{
                        
                        if let itemsArray = artistsDict["items"] as? JSONArray {
                            
                            for itemDict in itemsArray {
                                
                                let theArtist = Artist(dict: itemDict)
                                
                                print(theArtist.name)
                                print(theArtist.artistID)
                                
                                DataStore.sharedInstance.addArtist(theArtist)
                                
                            }
                            
                            
                        }
                    }
                
                } else {
                    
                    print("I could not parse the jsonDictionary")
                }
                
            })
            task.resume()
        }
        
    }
    
    func fetchAlbums (artistID: String) {
        
        let urlString = "https://api.spotify.com/v1/artists/\(artistID)/albums"
        
        if let url = NSURL(string: urlString){
            //3.Create a Data Task for pulling the data from the url
            
            let task = session.dataTaskWithURL(url, completionHandler: { (data, response, error) in
                
                if error != nil {
                 
                }
                
                if let jsonDictionary = self.parseJSON(data) {
                    // print(jsonDictionary)
                    
                    if let itemsArray = jsonDictionary["items"] as? JSONArray {
//                        print(itemsArray)
                        
                        for itemsDict in itemsArray {
                            
                            let theAlbum = Album(dict:itemsDict)
                            
                            print(theAlbum.name)
                            print(theAlbum.artistID)
                            
                            DataStore.sharedInstance.addAlbum(theAlbum)
                            
                        }
                        
                    } else {
                        
                        print("I could not parse albums array")
                    }
                    
                    
                } else {
                    print("I could not parse the dictionary")
                }
                
            })
            task.resume()
        }
  
    }
    
    func fetchRelatedArtists (artistID: String) {
        
        let urlString = "https://api.spotify.com/v1/artists/\(artistID)/related-artists"
        
        if let url = NSURL(string: urlString){
            //3.Create a Data Task for pulling the data from the url
            
            let task = session.dataTaskWithURL(url, completionHandler: { (data, response, error) in
                
                if error != nil {
                    
                }
                
                if let jsonDictionary = self.parseJSON(data) {
                    //
                    
                    if let artistsArray = jsonDictionary["artists"] as? JSONArray {
                        print(artistsArray)
                        
                        for artistsDict in artistsArray {
                            
                            let theRArtist = Artist(dict:artistsDict)
                            
                            print(theRArtist.name)
                            print(theRArtist.artistID)
                            
                            DataStore.sharedInstance.addRelatedArtist(theRArtist)

                        }
                        
                    } else {
                        
                        print("I could not parse related artists array")
                    }
                    
                    
                } else {
                    print("I could not parse the dictionary")
                }
                
            })
            task.resume()
        }

        
    }

    // This method allows us to send some NSData and get back a JSONDictionary
    
    func parseJSON(data:NSData?) -> JSONDictionary? {
            
        var theDictionary : JSONDictionary? = nil
            
            if let data = data {
            do {
                
            if let jsonDictionary = try NSJSONSerialization.JSONObjectWithData(data, options: []) as? JSONDictionary {
                    
                    
                theDictionary = jsonDictionary
                    
//                print (jsonDictionary)
                
                    
                } else {
                    print("Could not parse the jsonDictionary")
                }
                
            } catch {
                
            }
            
        } else {
            print("Could not unwrap data")
        
        }
        
        return theDictionary
        
    }

}
