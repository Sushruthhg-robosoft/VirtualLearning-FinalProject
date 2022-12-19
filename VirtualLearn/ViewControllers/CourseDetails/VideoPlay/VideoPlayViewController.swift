//
//  VideoPlayViewController.swift
//  SearchScreen
//
//  Created by Santhosh Patkar on 19/12/22.
//

import UIKit
import AVFoundation

class VideoPlayViewController: UIViewController {
    
    @IBOutlet weak var videoPlayView: UIView!
    var player = AVPlayer()
    var playerLayer = AVPlayerLayer()
    @IBOutlet weak var timeIndicatorLabel: UILabel!
    @IBOutlet weak var videoHeading: UILabel!
    @IBOutlet weak var viewTransitionIndicator: UIButton!
    @IBOutlet weak var timeSlider: UISlider!
    
    
    
    var isPlaying = true
    var isLandscape = false
    override func viewDidLoad() {
        super.viewDidLoad()

        playVideo()
        timeDisplay()
        
    }
    func playVideo() {
        
        let videoURL = URL(string: "https://player.vimeo.com/external/342571552.hd.mp4?s=6aa6f164de3812abadff3dde86d19f7a074a8a66&profile_id=175&oauth2_token_id=57447761")
        player = AVPlayer(url: videoURL!)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame.size.width = videoPlayView.frame.size.width
        playerLayer.frame.size.height = videoPlayView.frame.size.height
        playerLayer.videoGravity = .resizeAspectFill
        self.videoPlayView.layer.addSublayer(playerLayer)
        player.play()
    }
    
    override func viewDidLayoutSubviews() {
        playerLayer.frame = videoPlayView.bounds
    }
    
    @IBAction func playPauseButtonClicked(_ sender: UIButton) {
        if isPlaying{
            player.pause()
            sender.setImage(#imageLiteral(resourceName: "icn_play video-Play"), for: .normal)
            isPlaying = false
        } else{
            
            player.play()
            sender.setImage(#imageLiteral(resourceName: "Rotate Pause"), for: .normal)
            isPlaying = true
        }
    }
     
    func timeDisplay() {
        let interval = CMTime(value: 1, timescale: 1)
        player.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { (progressTime) in

        let seconds = CMTimeGetSeconds(progressTime)
        let secondString = String(format: "%02d", Int(seconds) % 60)
        let minutString = String(format: "%02d", Int(seconds) / 60)
        self.timeIndicatorLabel.text = "\(minutString):\(secondString)"
        guard let currentTime = self.player.currentItem else {return}
        self.timeSlider.maximumValue = Float(currentTime.duration.seconds)
        self.timeSlider.minimumValue = 0
        self.timeSlider.value = Float(currentTime.currentTime().seconds)
        
    } )
}
    @IBAction func rotateTapped(_ sender: Any) {
        if isLandscape{
            let value = UIInterfaceOrientation.portrait.rawValue
            UIDevice.current.setValue(value, forKey: "orientation")
            isLandscape = false
        }
        else{
        
            let value = UIInterfaceOrientation.landscapeLeft.rawValue
            UIDevice.current.setValue(value, forKey: "orientation")
            isLandscape = true
        }
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        
    }
}
