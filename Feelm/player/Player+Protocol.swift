//
//  Player+Protocol.swift
//  Feelm
//
//  Created by feel on 2020/07/14.
//  Copyright © 2020 ___FEEL___. All rights reserved.
//

import Foundation
import AVFoundation

@objc public protocol PlayerDelegate : NSObjectProtocol {
    /* audioRecorderDidFinishRecording:successfully: is called when a recording has been finished or stopped. This method is NOT called if the recorder is stopped due to an interruption. */
    @objc optional func playTimeUpdate(_ time:TimeInterval)
}
