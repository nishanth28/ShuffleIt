//
//  PlaySwift.swift
//  ShuffleIt
//
//  Created by Nishanth P on 12/4/16.
//  Copyright © 2016 Nishapp. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation
import AVKit

var musicPlayer : AVAudioPlayer = AVAudioPlayer()

class PlaySwift : UIViewController,AVAudioPlayerDelegate {
    
    
    @IBOutlet weak var nextImage: UIImageView!
    @IBOutlet weak var prevImage: UIImageView!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var timeline: UISlider!
    
    @IBOutlet weak var songName: UILabel!
    @IBOutlet weak var albumName: UILabel!
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var endTime: UILabel!
    
    var music = [String]()
    
    var prevImg = UIImage()
    var prevSongTitle = String()
    var prevArtist = String()
    var prevMainPreviewURL = String()
    
    var mainImg = UIImage()
    var songTitle = String()
    var artist = String()
    var mainPreviewURL = String()
    
    var nextImg = UIImage()
    var nextSongTitle = String()
    var nextArtist = String()
    var nextMainPreviewURL = String()
    
    
    var index : Int? // to keep track
    var timer : Timer = Timer()
    var imageCount : Int = 2
    
    var repeatOn : Bool = false
    var shuffleOn : Bool = false
    
    var image = [UIImage(named:"Maroon5"),UIImage(named:"Anirudh"),UIImage(named:"21Pilots"),UIImage(named:"irumugan"),UIImage(named:"Sia"),UIImage(named:"ImagineDragons"),UIImage(named:"Hoobastank"),UIImage(named:"Aym")]
    
    @IBAction func profileVC(_ sender: Any) {
        let vc : AnyObject! = self.storyboard!.instantiateViewController(withIdentifier: "Profile")
        self.show(vc as! UIViewController, sender: vc)
    }
    
    @IBAction func libraryVC(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func previous(_ sender: Any) {
        
         /*   if music.count > 0 {
                
                if !shuffleOn{
                    
                    index -= 1
                   
                    if index < 0{
                        index = music.count - 1
                        
                    }else{
                        
                        index = randomIndex()
                        
                    }
                    playMusic()
                }
                
            }*/
        
        if index!-1 < 0 {
            
            index = 1
            prevImage.image = songCells[index!-1].cellImage
            mainImage.image = songCells[index!-1].cellImage
            nextImage.image = songCells[index!].cellImage
            songName.text = songCells[index!-1].names
            mainPreviewURL = songCells[index!-1].previewURL
            albumName.text = songCells[index!-1].Artist
            
        }
        else{
            prevImage.image = songCells[index!-2].cellImage
            mainImage.image = songCells[index!-1].cellImage
            nextImage.image = songCells[index!].cellImage
            songName.text = songCells[index!-1].names
            mainPreviewURL = songCells[index!-1].previewURL
            albumName.text = songCells[index!-1].Artist
            
           
            
        }
        
        downloadFileFromURl(url: URL(string: mainPreviewURL)!)
        backgroundPlay()
        

        self.index = index! - 1


        
        
            
        
        
    }

   
    @IBAction func play(_ sender: UIButton) {
        
        if musicPlayer.isPlaying{
            musicPlayer.pause()
            sender.setImage(UIImage(named:"play"), for: .normal)
        }else{
            musicPlayer.play()
            sender.setImage(UIImage(named:"pause"), for: .normal)

        }
        
        
        
        
        
        if music.count > 0{
            
            if !musicPlayer.isPlaying{
                
                musicPlayer.play()
                sender.setImage(UIImage(named:"play"), for: .normal)
                //set the UIImage for play
            }else{
                musicPlayer.pause()
                sender.setImage(UIImage(named:"pause"), for: .normal)
                //set UIImage for paus
            }
            
        }
        
    }
    
    @IBAction func next(_ sender: UIButton)
     {
        
       /* if music.count > 0 {
            
            if !shuffleOn{
                
                index += 1
                imageCount += 1
              
                if index == music.count-1{
                    index = 0
                    
                }else{
                    
                    index = randomIndex()
                   
                }
                playMusic()
            }
            
        } */
        
        if index!+1 > songCells.count{
            
            index = -1
            prevImage.image = songCells[songCells.count].cellImage
            mainImage.image = songCells[index!+1].cellImage
            nextImage.image = songCells[index!+2].cellImage
            songName.text = songCells[index!+1].names
            mainPreviewURL = songCells[index!+1].previewURL
            albumName.text = songCells[index!+1].Artist
            
                    }
        else{
            prevImage.image = songCells[index!].cellImage
            mainImage.image = songCells[index!+1].cellImage
            nextImage.image = songCells[index!+2].cellImage
            songName.text = songCells[index!+1].names
            mainPreviewURL = songCells[index!+1].previewURL
            albumName.text = songCells[index!+1].Artist
            
          
        }
        self.index = index! + 1
        downloadFileFromURl(url: URL(string: mainPreviewURL)!)
        backgroundPlay()
        

    }
    
    func randomIndex() -> Int {
        
        let index: Int = Int(arc4random_uniform(UInt32(music.count)))
        
        return index
        
    }
    
    @IBAction func shuffle(_ sender: UIButton) {
        
        if shuffleOn {
            
            sender.setImage(UIImage(named: "shuffleOFF"), for: .normal)
        }else
        {
            sender.setImage(UIImage(named: "shuffle"), for: .normal)
        }
        shuffleOn = !shuffleOn
        
    }
    
    @IBAction func repeatSong(_ sender: UIButton) {
        
        if repeatOn {
            
            sender.setImage(UIImage(named: "repeatOFF"), for: .normal)
        }else
        {
             sender.setImage(UIImage(named: "repeat"), for: .normal)
        }
        repeatOn = !repeatOn
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateSlider), userInfo: nil, repeats: true)
        
        downloadFileFromURl(url: URL(string: mainPreviewURL)!)
        backgroundPlay()
        
        
        timeline.setThumbImage(UIImage(named:"Rectangle 8.jpg"), for: UIControlState.normal)
        
        if index! == 1{
            prevImage.image = songCells[songCells.count].cellImage
            nextImage.image = songCells[index!+1].cellImage
            songName.text = songCells[index!].names
            mainImage.image = songCells[index!].cellImage
            //backgroundImg.image = nil
            albumName.text = songCells[index!].Artist

            timeline.value = 0
        }
        if index! > 1 && index!<songCells.count
        {
            nextImage.image = songCells[index!+1].cellImage
            prevImage.image = songCells[index!-1].cellImage
            songName.text = songCells[index!].names
            mainImage.image = songCells[index!].cellImage
            albumName.text = songCells[index!].Artist
            timeline.value = 0
        }
        if index! >= songCells.count
        {
            nextImage.image = songCells[0].cellImage
            prevImage.image = songCells[index!-1].cellImage
            songName.text = songCells[index!].names
            mainImage.image = songCells[index!].cellImage
            albumName.text = songCells[index!].Artist
            timeline.value = 0
        }
        
       
        
        mainImage.layer.borderWidth = 2
        mainImage.layer.borderColor = UIColor.white.cgColor
        
        prevImage.layer.borderWidth = 2
        prevImage.layer.borderColor = UIColor.white.cgColor
        
        nextImage.layer.borderWidth = 2
        nextImage.layer.borderColor = UIColor.white.cgColor
        
        
        //********** loadMusicFiles()
        //if music.count > 0 {
            
          //  playMusic()
        
        //*******************}
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func loadMusicFiles(){
        
        let resourcePath :String = Bundle.main.resourcePath!
        var directoryContents = [String]()
        do{
            directoryContents = try FileManager.default.contentsOfDirectory(atPath: resourcePath) as [String]
        }catch{
            print("Error fetching data")
        }
        
        for i in 0...directoryContents.count - 1{
            let fileExtension: String = (directoryContents[i] as NSString).pathExtension as String
            if fileExtension == "mp3" {
                
                let fileName:String = directoryContents[i]
                music.append(fileName)
                
            }
            
        }
        
    }
    
    
    func playMusic(){
        
        
        
        let filePath = Bundle.main.path(forResource:music[index!],ofType:nil)
        let fileURL = URL(fileURLWithPath:filePath!)
            do{
                    musicPlayer = try AVAudioPlayer(contentsOf: fileURL)
            }catch{
            print("Error playing music")
            }
        
        musicPlayer.delegate = self
        timeline.minimumValue = 0
        timeline.maximumValue = Float(musicPlayer.duration)
        timeline.value = Float(musicPlayer.currentTime)
        
            do{
                try AVAudioSession.sharedInstance().overrideOutputAudioPort(AVAudioSessionPortOverride.speaker)
            }catch _{
            }
        startTime.text = String(Float(musicPlayer.currentTime))
        endTime.text=String(Float(musicPlayer.duration))
        
        musicPlayer.volume = 1
        musicPlayer.prepareToPlay()
        musicPlayer.play()
        songName.text = music[index!]
        
        
        
    }
    
    func updateSlider(){
        
        timeline.value = Float(musicPlayer.currentTime)
        
        
    }
    
    func getTime(currentTime: TimeInterval) -> String{
        
        let current = currentTime
        _ = Int(currentTime/60)
        let sec = Float(current).truncatingRemainder(dividingBy: 60)
        
        //let minString = min>9 ? "\(min)":"0\(min)"
        let secString = sec>10 ? String(format:"%.2f",sec):"0"+String(format:"%.2f",sec)
        
        return secString
    }
    
    func downloadFileFromURl(url: URL)
    {
        var downloadTask = URLSessionDownloadTask()
        downloadTask = URLSession.shared.downloadTask(with: url, completionHandler: {
            customURL, response, error in
          self.playSpotify(url: customURL!)
        })
        downloadTask.resume()
    }
    
    func playSpotify(url: URL)
    {
        
        do{
            musicPlayer = try AVAudioPlayer(contentsOf: url)
            musicPlayer.delegate = self
            timeline.minimumValue = 0
            timeline.maximumValue = Float(musicPlayer.duration)
            timeline.value = Float(musicPlayer.currentTime)
            do{
                try AVAudioSession.sharedInstance().overrideOutputAudioPort(AVAudioSessionPortOverride.speaker)
            }catch _{
            }
            startTime.text = String(Float(musicPlayer.currentTime))
            endTime.text=String(Float(musicPlayer.duration))
            musicPlayer.prepareToPlay()
            musicPlayer.play()
        }catch{
            print("Player Error")
        }
        
        
    }
    
    func backgroundPlay(){
    do {
        try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
        print("AVAudioSession Category Playback OK")
        do {
            try AVAudioSession.sharedInstance().setActive(true)
                print("AVAudioSession is Active")
            }
                catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
            catch let error as NSError {
            print(error.localizedDescription)
        
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

