//
//  LibraryViewController.swift
//  ShuffleIt
//
//  Created by Nishanth P on 12/3/16.
//  Copyright © 2016 Nishapp. All rights reserved.
//


import Foundation
import UIKit
import Alamofire
import NVActivityIndicatorView

struct songCell {
    
    let cellImage : UIImage!
    let names : String!
    let previewURL : String!
    let Artist: String!
    
}

var songCells = [songCell]()

class LibraryViewController: UIViewController, UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate {
    
    @IBOutlet weak var spinner: UIView!
    @IBOutlet weak var libraryTable: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    typealias JSONStd = [String:AnyObject]
    
    
    
    var keywords : String!
    
   //  var songCells = [songCell]()
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        songCells = []
        self.keywords = searchBar.text
        let finalkeywords = keywords?.replacingOccurrences(of: " ", with: "+")
        
        let search = "https://api.spotify.com/v1/search?q=\(finalkeywords!)&limit=50&type=track"
        alamo(url:search)
        self.view.endEditing(true)
        libraryTable.isHidden = false
        searchMusicLabel.isHidden = true
        NVActivityIndicatorView.DEFAULT_TYPE = .lineScale
        let activityData = ActivityData()
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
        
    }
    
   // var names = [String]()
    
    //var names1 = ["Animals","Enakenna Yarum ilaye","Heathens","Helena","CheapThrills","RadioActive","Reasons","Thallipogathey"]
    //var albums = ["Maroon5","AAKKO","21Pilots","Irumugan","Sia","ImagineDragons","HoobaStank","AYM"]
   // var image = [UIImage(named:"Maroon5"),UIImage(named:"Anirudh"),UIImage(named:"21Pilots"),UIImage(named:"irumugan"),UIImage(named:"Sia"),UIImage(named:"ImagineDragons"),UIImage(named:"Hoobastank"),UIImage(named:"Aym")]
     
    
    @IBOutlet weak var searchMusicLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            libraryTable.isHidden = true
            searchMusicLabel.isHidden = false
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func alamo(url:String)
    {
        
        Alamofire.request(url).responseJSON(completionHandler: {
            response in
            self.parseData(JSONData: response.data!)
        })
        
    }
    
    func parseData(JSONData: Data)
    {
        do {
            var readableJSON = try JSONSerialization.jsonObject(with: JSONData, options: .mutableContainers) as! JSONStd
            print(readableJSON)
            if let tracks = readableJSON["tracks"] as? JSONStd{
                if let items = tracks["items"] as? [JSONStd] {
                    
                    for i in 0..<items.count{
                        let item = items[i]
                        let name = item["name"] as! String
                        let previewURL = item["preview_url"] as! String
                        
                        if let album = item["album"] as? JSONStd {
                            if let images = album["images"] as? [JSONStd]{
                            let imageData = images[0]
                            let imageURL = URL(string: imageData["url"] as! String)
                            let cellImageData = NSData(contentsOf: imageURL!)
                            let cellImage = UIImage(data: cellImageData as! Data)
                                
                                songCells.append(songCell.init(cellImage: cellImage ,names: name,previewURL: previewURL,Artist: keywords))
                                DispatchQueue.main.async(execute: {
                                    self.libraryTable.reloadData()
                                    return
                                })
                                
                           }
                        }
                    }
                }
                
            }
            
        }
        catch{
            print("Error while parsing JSON")
        }
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return songCells.count
    }
    
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell1 = self.libraryTable.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! LibraryCell
        
        cell1.backgroundColor = UIColor.clear
        let cellImageView = cell1.viewWithTag(1) as! UIImageView
        cellImageView.image = songCells[indexPath.row].cellImage
        let songName = cell1.viewWithTag(2) as! UILabel
        songName.text = songCells[indexPath.row].names
        let AlbumName = cell1.viewWithTag(3) as! UILabel
        AlbumName.text = songCells[indexPath.row].Artist.capitalized
        
        //cellImageView.layer.borderWidth = 2
        //cellImageView.layer.borderColor = UIColor.white.cgColor
        
       // cell1.libraryImage.image = image[1]
        //cell1.librarySongName.text = names[indexPath.row]
        //cell1.libraryAlbumName.text = albums[1]
        
        return cell1
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let indexPath = self.libraryTable.indexPathForSelectedRow?.row
        let ps = segue.destination as! PlaySwift
        
        ps.songTitle = songCells[indexPath!].names
        ps.mainImg = songCells[indexPath!].cellImage
        ps.mainPreviewURL = songCells[indexPath!].previewURL
        ps.artist = songCells[indexPath!].Artist
        ps.index = indexPath!
                
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
     //   let customColor : UIColor = UIColor(colorLiteralRed: 13/255 , green:60/255, blue:76/255 , alpha: 1.0)
       // tabBarController?.tabBar.backgroundColor = customColor
        
       // self.tabBarController?.tabBar.tintColor = UIColor.white
       // self.tabBarController?.tabBar.barTintColor = UIColor.init(colorLiteralRed: 0.13, green: 0.14, blue: 0.15, alpha: 1)
       // self.tabBarController?.tabBar.backgroundImage = UIImage(named:"clearColor")
       
      
      //  self.tabBarController?.tabBar.backgroundColor = UIColor.clear
      //  self.tabBarController?.tabBar.backgroundImage = UIImage(named:"clearColor")
       // self.tabBarController?.tabBar.isTranslucent = true
         self.tabBarController?.tabBar.tintColor = UIColor.white
        
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
