//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    let eggTimes = ["Soft": 3, "Medium": 4, "Hard": 7]
    var secondsPassed = 0
    var secondsTotal = 60
    var timer = Timer()
    var player: AVAudioPlayer!

    @IBOutlet weak var headerView: UILabel!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        let hardness = sender.currentTitle!
        secondsTotal = eggTimes[hardness]!
        
        timer.invalidate()
        progressBar.progress = 0.0
        secondsPassed = 0
        headerView.text = hardness
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        progressBar.progress = Float(secondsPassed) / Float(secondsTotal)
        if secondsPassed < secondsTotal {
            secondsPassed += 1
        } else {
            playSound()
            timer.invalidate()
            headerView.text = "Done"
        }
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
}

