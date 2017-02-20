//
//  ProfileViewController.swift
//  ShuffleIt
//
//  Created by Nishanth P on 12/2/16.
//  Copyright © 2016 Nishapp. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var displayImage: UIImageView!
    @IBOutlet weak var displayName: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var AuthStatus : String!
    var display_Name : String!
    var display_Pic : UIImage!
    
    var names = ["CheapThrills","RadioActive","Reasons","Thallipogathey"]
    var albums = ["Sia","ImagineDragons","HoobaStank","AYM"]
    var image = [UIImage(named:"Sia"),UIImage(named:"ImagineDragons")]
    var image2 = [UIImage(named:"Hoobastank"),UIImage(named:"Aym")]
    

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
       return names.count/2
    }
    
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! customCell
        cell.songImage.layer.borderWidth = 2
        cell.songImage.layer.borderColor = UIColor.white.cgColor
        cell.songImage2.layer.borderWidth = 2
        cell.songImage2.layer.borderColor = UIColor.white.cgColor

        cell.backgroundColor = UIColor.clear
        
        cell.songImage.image = image[indexPath.row]
        cell.songImage2.image = image2[indexPath.row]
        
        //cell.songName.text = names[indexPath.row]
        //cell.albumName.text = albums[indexPath.row]
        
        return cell
    }
    
    override func viewDidAppear(_ animated: Bool) {
         self.tabBarController?.tabBar.tintColor = UIColor.white
    
            }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayName.text = display_Name
        displayImage.image = display_Pic
        self.displayImage.layer.borderWidth = 3.0
        self.displayImage.layer.borderColor = UIColor.white.cgColor
        self.displayImage.layer.cornerRadius = self.displayImage.frame.height/2
        self.displayImage.clipsToBounds = true
        
        self.tabBarController?.tabBar.tintColor = UIColor.white
      
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
