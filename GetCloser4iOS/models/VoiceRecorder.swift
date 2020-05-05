//
//  VoiceRecorder.swift
//  GetCloser4iOS
//
//  Created by gridscale on 2020/05/05.
//  Copyright © 2020 gridscale. All rights reserved.
//

import Foundation
import AVFoundation

class VoiceRecorder {
    
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    
    func finishRecording(success: Bool) {
        audioRecorder.stop()
        audioRecorder = nil
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func startRecording() {
        let audioFilename = getDocumentsDirectory().appendingPathComponent("recording.m4a")

        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]

        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder.record()

        } catch {
            finishRecording(success: false)
        }
    }
}
