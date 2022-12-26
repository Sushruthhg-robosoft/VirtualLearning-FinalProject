//
//  VideoPlayViewController.swift
//  SearchScreen
//
//  Created by Santhosh Patkar on 19/12/22.
//

import UIKit
import AVFoundation
import AVKit
import CoreMedia

protocol PauseVideoStatus{
    func sendTime(second: Int)
}

class VideoPlayViewController: UIViewController {
    
    @IBOutlet weak var videoPlayView: UIView!
    var player = AVPlayer()
    var playerLayer = AVPlayerLayer()
    @IBOutlet weak var timeIndicatorLabel: UILabel!
    @IBOutlet weak var videoHeading: UILabel!
    @IBOutlet weak var viewTransitionIndicator: UIButton!
    @IBOutlet weak var timeSlider: UISlider!
    
    var url : String?
    var heading: String?
    var seconds: Int?
    var isPlaying = true
    var isLandscape = false
    var delegate: PauseVideoStatus?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        playVideo()
        timeDisplay()
        //        addTimeobserver()
        player.play()
        videoHeading.text = heading
    }
    func seek(to seconds: Int) {
        let targetTime:CMTime = CMTimeMake(value: Int64(seconds), timescale: 1)
        player.seek(to: targetTime)
    }
    func playVideo() {
        let videoURL = URL(string: url!)
        
        player = AVPlayer(url: videoURL!)
        playerLayer = AVPlayerLayer(player: player)
        
        playerLayer.frame.size.width = videoPlayView.frame.size.width
        playerLayer.frame.size.height = videoPlayView.frame.size.height
        playerLayer.videoGravity = .resizeAspectFill
        self.videoPlayView.layer.addSublayer(playerLayer)
        let time = CMTime(seconds: Double(seconds ?? 0), preferredTimescale: 1)
        let toleranceBefore = CMTime(seconds: 0.1, preferredTimescale: 1)
        let toleranceAfter = CMTime(seconds: 0.1, preferredTimescale: 1)
        player.seek(to: time, toleranceBefore: toleranceBefore, toleranceAfter: toleranceAfter)
        addTimeobserver()
    }
    
    override func viewDidLayoutSubviews() {
        playerLayer.frame = videoPlayView.bounds
    }
    
    @IBAction func playPauseButtonClicked(_ sender: UIButton) {
        if isPlaying{
            player.pause()
            sender.setImage(#imageLiteral(resourceName: "icn_play video-Play"), for: .normal)
            isPlaying = false
            let interval = CMTime(value: 1, timescale: 1)
            player.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { (progressTime) in
                let seconds = CMTimeGetSeconds(progressTime)
            })
        } else{
            
            player.play()
            sender.setImage(#imageLiteral(resourceName: "Rotate Pause"), for: .normal)
            isPlaying = true
        }
    }
    
    @IBAction func timeSliderChanged(_ sender: UISlider) {
        player.seek(to: CMTimeMake(value: Int64(sender.value*1000), timescale: 1000))
    }
    func addTimeobserver(){
        let interval = CMTime(seconds: 0.5, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        let mainQueue = DispatchQueue.main
        DispatchQueue.main.async {
            
            _ = self.player.addPeriodicTimeObserver(forInterval: interval, queue: mainQueue, using: { [weak self] time in
                guard let currentTime = self?.player.currentItem else {return}
                guard currentTime.duration >= .zero, !currentTime.duration.seconds.isNaN else {
                    return
                }
                self?.timeSlider.maximumValue = Float(currentTime.duration.seconds)
                self?.timeSlider.minimumValue = 0
                self?.timeSlider.value = Float(currentTime.currentTime().seconds )
            })
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
            guard currentTime.duration >= .zero, !currentTime.duration.seconds.isNaN else {
                return
            }
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
        player.pause()
//        let interval = CMTime(value: 1, timescale: 1)
        
//        player.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { (progressTime) in
//            let seconds = CMTimeGetSeconds(progressTime)
//            print(2345678,Int(seconds))
//            self.delegate?.sendTime(second: Int(seconds))
//        })
        navigationController?.popViewController(animated: true)
        let currentTime = player.currentTime()
        self.delegate?.sendTime(second: Int(currentTime.seconds))
        
    }
    
    
}
