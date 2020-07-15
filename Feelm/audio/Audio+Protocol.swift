//
//  Audio+Protocol.swift
//  Feelm
//
//  Created by feel on 2020/07/10.
//  Copyright © 2020 ___FEEL___. All rights reserved.
//

import AVFoundation

@objc public protocol AudioRecorderDelegate : NSObjectProtocol {
    /* audioRecorderDidFinishRecording:successfully: is called when a recording has been finished or stopped. This method is NOT called if the recorder is stopped due to an interruption. */
    @objc optional func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool)

    
    /* if an error occurs while encoding it will be reported to the delegate. */
    @objc optional func audioRecorderEncodeErrorDidOccur(_ recorder: AVAudioRecorder, error: Error?)
    
    @objc optional func audioRecordingTimeUpdate(_ time:TimeInterval)
}
