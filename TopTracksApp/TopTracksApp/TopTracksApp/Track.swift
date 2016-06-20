//
//  Track.swift
//  TopTracksApp
//
//  Created by Taylor Frost on 6/20/16.
//  Copyright © 2016 Taylor Frost. All rights reserved.
//

import UIKit

class Track: NSObject {

    
    var name: String = ""
    var previewURL : String = ""
    
    
    override init () {
        super.init()
        
        self.name = ""
        self.previewURL = ""
    }
    
    init(dict:JSONDictionary) {
        super.init()
        
        if let name = dict["name"] as? String {
            self.name = name
            
            
        } else {
            print("I could not parse the track name")
        }
        
        if let previewURL = dict["preview_url"] as? String {
            self.previewURL = previewURL
            
        } else {
            print("I could not parse the previewURL")
        }

        
        
    }
    
    

}
