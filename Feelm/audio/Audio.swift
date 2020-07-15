//
//  Audio.swift
//  Feelm
//
//  Created by feel on 2020/07/10.
//  Copyright © 2020 ___FEEL___. All rights reserved.
//

import UIKit
import AVFoundation

public class Audio: NSObject, AVAudioRecorderDelegate {
    var MAX_VOLUME:Float = 10.0
    var audioRecorder:AVAudioRecorder!
    var audioFormat:AudioFormat! = AudioFormat.init()
    public var audioFile:URL!
    public var isRecording = false
    
    var progressTimer: Timer!          //타이머를 위한 변수
    let timeRecordSelector:Selector = #selector(updateRecordTime)
    
    public var recordTime:TimeInterval = 0.0
    public var maxRecordTime:TimeInterval = 30
    public var delegate:AudioRecorderDelegate?
    
    public func readyToREC(){
        do {
            // selectAudioFile 함수에서 저장한 audioFile을 url로 하는 audioRecorder 인스턴스를 생성
            let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            self.audioFile = documentDirectory.appendingPathComponent("rec_audio_tmp.mp4")
            self.audioRecorder = try AVAudioRecorder(url: self.audioFile, settings: self.audioFormat.getSttings())
        } catch let error as NSError {
            print("error-initRecord:\(error)")
        }

        self.audioRecorder.delegate = self

        //박자관련
        self.audioRecorder.isMeteringEnabled = true
        self.audioRecorder.prepareToRecord()
        
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(AVAudioSession.Category.playAndRecord)
        } catch let error as NSError {
            print("error-setcategory : \(error)")
        }

        do {
            try session.setActive(true)
        } catch let error as NSError {
            print("error-setActive : \(error)")
        }
    }
    
    public func onREC(){
        self.recordTime = 0.0
        self.audioRecorder.record()
        self.progressTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: timeRecordSelector, userInfo: nil, repeats: true)
        self.isRecording = true
    }
    
    public func stopREC(){
        self.audioRecorder.stop()
        self.progressTimer.invalidate()
    }
    
    @objc func updateRecordTime(){
        self.recordTime = audioRecorder.currentTime
        self.delegate?.audioRecordingTimeUpdate?(self.recordTime)
    }
    
    /* audioRecorderDidFinishRecording:successfully: is called when a recording has been finished or stopped. This method is NOT called if the recorder is stopped due to an interruption. */
    public func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        self.isRecording = false
        self.delegate?.audioRecorderDidFinishRecording?(recorder, successfully: flag)
    }

    /* if an error occurs while encoding it will be reported to the delegate. */
    public func audioRecorderEncodeErrorDidOccur(_ recorder: AVAudioRecorder, error: Error?) {
        self.isRecording = false
        self.delegate?.audioRecorderEncodeErrorDidOccur?(recorder, error: error)
    }
}
