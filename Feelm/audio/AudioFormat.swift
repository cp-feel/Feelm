//
//  AudioFormat.swift
//  Feelm
//
//  Created by feel on 2020/07/10.
//  Copyright © 2020 ___FEEL___. All rights reserved.
//

import UIKit
import AVFoundation

public class AudioFormat: NSObject {
    public var audioFormat:NSNumber = NSNumber(value : kAudioFormatMPEG4AAC as UInt32)
    public var audioQuality:Int = AVAudioQuality.max.rawValue
    public var audioEncoderBitRate:Int = 320000
    public var audioChannels:Int = 2
    public var audioSamplingRate:Double = 44100.0
    
    func getSttings()->[String:Any] {
        let recordSettings = [
            AVFormatIDKey : self.audioFormat,
            AVEncoderAudioQualityKey : self.audioQuality,
            AVEncoderBitRateKey : self.audioEncoderBitRate,
            AVNumberOfChannelsKey : self.audioChannels,
            AVSampleRateKey : self.audioSamplingRate] as [String : Any]
        
        return recordSettings
    }
}
