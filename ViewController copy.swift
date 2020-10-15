//
//  ViewController.swift
//  StopWatchApp
//
//  Created by Grace Olson on 5/31/20.
//  Copyright © 2020 Grace Olson. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    
    @IBOutlet weak var musicButton: UIButton!
    
    @IBOutlet weak var musicOffButton: UIButton!
    
    
    var timer = Timer()
    var isTimerRunning = false
    var counter = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resetButton.isEnabled = false
        pauseButton.isEnabled = false
        startButton.isEnabled = true
        
        startButton.layer.cornerRadius = startButton.bounds.width / 2.0
        startButton.layer.masksToBounds = false
        
        backgroundColours = [UIColor.init(red: 226/255, green: 102/255, blue: 98/255, alpha: 1.0), UIColor.init(red: 255/255, green: 134/255, blue: 116/255, alpha: 1.0),UIColor.init(red: 255/255, green: 160/255, blue: 106/255, alpha: 1.0), UIColor.init(red: 254/255, green: 203/255, blue: 139/255, alpha: 1.0), UIColor.init(red: 252/255, green: 215/255, blue: 87/255, alpha: 1.0),UIColor.init(red: 245/255, green: 225/255, blue: 164/255, alpha: 1.0),UIColor.init(red: 224/255, green: 236/255, blue: 137/255, alpha: 1.0),UIColor.init(red: 183/255, green: 221/255, blue: 121/255, alpha: 1.0),UIColor.init(red: 147/255, green: 218/255, blue: 73/255, alpha: 1.0),UIColor.init(red: 44/255, green: 200/255, blue: 77/255, alpha: 1.0),UIColor.init(red: 0/255, green: 187/255, blue: 126/255, alpha: 1.0),UIColor.init(red: 0/255, green: 149/255, blue: 122/255, alpha: 1.0),UIColor.init(red: 40/255, green: 147/255, blue: 156/255, alpha: 1.0),UIColor.init(red: 0/255, green: 165/255, blue: 189/255, alpha: 1.0),UIColor.init(red: 0/255, green: 181/255, blue: 226/255, alpha: 1.0),UIColor.init(red: 0/255, green: 134/255, blue: 191/255, alpha: 1.0),UIColor.init(red: 0/255, green: 112/255, blue: 150/255, alpha: 1.0),UIColor.init(red: 0/255, green: 103/255, blue: 185/255, alpha: 1.0),UIColor.init(red: 58/255, green: 93/255, blue: 174/255, alpha: 1.0),UIColor.init(red: 68/255, green: 73/255, blue: 156/255, alpha: 1.0),UIColor.init(red: 89/255, green: 73/255, blue: 167/255, alpha: 1.0), UIColor.init(red: 125/255, green: 85/255, blue: 199/255, alpha: 1.0),UIColor.init(red: 167/255, green: 123/255, blue: 202/255, alpha: 1.0),UIColor.init(red: 221/255, green: 156/255, blue: 223/255, alpha: 1.0), UIColor.init(red: 236/255, green: 134/255, blue: 208/255, alpha: 1.0),UIColor.init(red: 244/255, green: 166/255, blue: 215/255, alpha: 1.0),UIColor.init(red: 248/255, green: 181/255, blue: 196/255, alpha: 1.0),UIColor.init(red: 255/255, green: 128/255, blue: 139/255, alpha: 1.0),UIColor.init(red: 246/255, green: 82/255, blue: 117/255, alpha: 1.0),UIColor.init(red: 231/255, green: 60/255, blue: 62/255, alpha: 1.0)]
        
        backgroundLoop = 0
        self.animateBackgroundColour()
        
        startButton.backgroundColor = UIColor.init(red: 226/255, green: 102/255, blue: 98/255, alpha: 1.0)
        
    }
    
    @IBAction func resetDidTap(_ sender: Any) {
        timer.invalidate()
        isTimerRunning = false
        counter = 0.0
        
        timerLabel.text = "00:00:00"
        resetButton.isEnabled = false
        pauseButton.isEnabled = false
        startButton.isEnabled = true
    }
    
    @IBAction func pauseDidTap(_ sender: Any) {
        resetButton.isEnabled = true
        startButton.isEnabled = true
        pauseButton.isEnabled = false
        
        isTimerRunning = false
        timer.invalidate()
    }
    
    @IBAction func startDidTap(_ sender: Any) {
        if !isTimerRunning {
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(runTimer), userInfo: nil, repeats: true)
            isTimerRunning = true
            
            resetButton.isEnabled = true
            pauseButton.isEnabled = true
            startButton.isEnabled = false
            
        }
    }
    
    var backgroundPlayer = AVAudioPlayer()
       
       func playBackgroundMusic (fileNamed: String){
           
           let url = Bundle.main.url(forResource: fileNamed, withExtension: nil)
           
           do {
               backgroundPlayer = try AVAudioPlayer(contentsOf: url!)
               backgroundPlayer.numberOfLoops = -1
               backgroundPlayer.prepareToPlay()
               backgroundPlayer.play()
           }
           catch let error as NSError {
               print(error.description)
           }
       }
       
       func stopBackgroundMusic (fileNamed: String){
           
           let url = Bundle.main.url(forResource: fileNamed, withExtension: nil)
           
           do {
               backgroundPlayer = try AVAudioPlayer(contentsOf: url!)
               backgroundPlayer.stop()
           }
           catch let error as NSError {
               print(error.description)
           }
       }
    
    @IBAction func musicButtonDidTap(_ sender: Any) {
        playBackgroundMusic(fileNamed: "backgroundMusic.mp3")
    }
    
    
    @IBAction func musicOffButtonDidTap(_ sender: Any) {
        stopBackgroundMusic(fileNamed: "backgroundMusic.mp3")
    }
    
    
    
    //Mark: -Helper methods
    
    @objc func runTimer() {
        counter += 0.1
        // HH:MM:SS
        let flooredCounter = Int(floor(counter))
        
        let hour = flooredCounter / 3600
        
        var hourString = "\(hour)"
        if hour < 10 {
            hourString = "0\(hour)"
        }
        
        let minute = (flooredCounter % 3600) / 60
        
        var minuteString = "\(minute)"
        if minute < 10 {
            minuteString = "0\(minute)"
        }
        
        let second = (flooredCounter % 3600) % 60
        
        var secondString = "\(second)"
        if second < 10 {
            secondString = "0\(second)"
        }
        
        timerLabel.text = "\(hourString):\(minuteString):\(secondString)"
        
    }
    
    var backgroundColours = [UIColor()]
    var backgroundLoop = 0
    
    func animateBackgroundColour () {
        if backgroundLoop < backgroundColours.count - 1 {
            backgroundLoop+=1
        } else {
            backgroundLoop = 0
        }
        UIView.animate(withDuration: 1, delay: 0, options: UIView.AnimationOptions.allowUserInteraction, animations: { () -> Void in
            self.startButton.backgroundColor =  self.backgroundColours[self.backgroundLoop];
            }) {(Bool) -> Void in
                self.animateBackgroundColour();
            }
        }
}
