//
//  ViewController.swift
//  TopTracksApp
//
//  Created by Taylor Frost on 6/20/16.
//  Copyright © 2016 Taylor Frost. All rights reserved.
//

import UIKit

class ArtistsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let apiController = APIController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.apiController.fetchArtists("3vDpQbGnzRbRVirXlfQagB")
        
        self.apiController.fetchAlbums("3vDpQbGnzRbRVirXlfQagB")
        
//        self.apiController.fetchArtists("u2")
        
//        self.apiController.fetchTopTracks("3vDpQbGnzRbRVirXlfQagB")
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        cell.textLabel?.text = "Test"
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
}
