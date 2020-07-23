//
//  Player.swift
//  Feelm
//
//  Created by feel on 2020/07/13.
//  Copyright © 2020 ___FEEL___. All rights reserved.
//

import UIKit
import AVFoundation

public class Player: NSObject {
    var avPlayer : AVPlayer!
    var playFile : URL!                // 재생할 오디오의 파일명 변수
    
    public let MAX_VOLUME : Float = 10.0       //최대 불륨, 실수형 상수
    public var volume:Float = 10.0
    public var isPlaying = false
    public var isReadyForPlay = false
    public var maxPlayTime = 0.0
    
    var progressTimer: Timer!          //타이머를 위한 변수
    let timeRecordSelector:Selector = #selector(updatePlayTime)
    
    public var delegate:PlayerDelegate?
    
    public func readyToPlay(_ playFile:URL!){
        //에러 처리
        self.playFile = playFile
        self.avPlayer = AVPlayer(url: playFile)
        //self.avPlayer.seek(to: CMTime.zero)
        
        //audioplayer의 델리게이트를 self로 한다.
//        self.audioPlayer.delegate = self
        //prepareToplay 실행한다.
//        self.audioPlayer.prepareToPlay()
        //오디오 플레이어의 블륨 초기화 한다.
//        self.audioPlayer.volume = self.volume
        self.avPlayer.volume = self.volume
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEnd(notification:)), name: .AVPlayerItemDidPlayToEndTime, object: avPlayer?.currentItem)
        
        self.isPlaying = false
        self.isReadyForPlay = true
    }
    
    public func play(){
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
        }
        catch {
            print("Setting category to AVAudioSessionCategoryPlayback failed.")
        }
//        self.audioPlayer.play()
        if self.avPlayer == nil {
            return
        }
        if self.progressTimer != nil {
            self.progressTimer.invalidate()
            self.progressTimer = nil
        }
        
        self.avPlayer.play()
        self.isPlaying = true
        self.progressTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: timeRecordSelector, userInfo: nil, repeats: true)
    }
    
    public func stop(){
//        self.audioPlayer.stop()
//        self.audioPlayer.currentTime = 0
//        self.avPlayer.()
        self.avPlayer.pause()
        self.avPlayer.seek(to: CMTime.zero)
        self.isPlaying = false
        if self.progressTimer != nil {
            self.progressTimer.invalidate()
            self.progressTimer = nil
        }
    }
    
    public func pause(){
//        self.audioPlayer.pause()
        self.avPlayer.pause()
        self.isPlaying = false
        if self.progressTimer != nil {
            self.progressTimer.invalidate()
            self.progressTimer = nil
        }
    }
    
    public func addItem(){
        
    }
    
    @objc func updatePlayTime(){
//        print("Player Timer")
        let time = self.avPlayer.currentTime().seconds
        self.delegate?.playTimeUpdate?(time)
        if(self.maxPlayTime > 0 && time >= self.maxPlayTime){
            self.avPlayer.seek(to: CMTime.zero)
        }
    }
    
    @objc func playerItemDidReachEnd(notification: Notification) {
//        print("Play End Check")
        if let playerItem = notification.object as? AVPlayerItem {
            playerItem.seek(to: CMTime.zero)
            self.play()
        }
    }
}
