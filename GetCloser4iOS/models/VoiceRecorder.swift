//
//  VoiceRecorder.swift
//  GetCloser4iOS
//
//  Created by gridscale on 2020/05/05.
//  Copyright © 2020 gridscale. All rights reserved.
//

import Foundation
import AVFoundation

class VoiceRecorder : NSObject, ObservableObject, AVAudioRecorderDelegate {
    
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer!
    var contentsUrl: URL?
    @Published var contentReady: Bool = false
    
    func finishRecording(success: Bool) {
        
        audioRecorder.stop()
        if (success) {
            contentsUrl = audioRecorder.url
            contentReady = true
        }
        
        audioRecorder = nil
    }
    
    func playback() {
        if (contentsUrl == nil) {
            return
        }
        
        recordingSession = AVAudioSession.sharedInstance()
        do {
            try recordingSession.setCategory(.playback, mode: .default)
            try recordingSession.setActive(true)
        } catch {
            print(error)
        }
        
        print(contentsUrl!)
        
        DispatchQueue.global(qos: .background).async {
            do {
                self.audioPlayer = try AVAudioPlayer(contentsOf: self.contentsUrl!)
                self.audioPlayer.prepareToPlay()
                self.audioPlayer.play()
            } catch {
                print(error)
            }
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func startRecording() {
        
        recordingSession = AVAudioSession.sharedInstance()

        do {
            try recordingSession.setCategory(.record, mode: .default)
            try recordingSession.setActive(true)
        } catch {
            print(error)
        }
        
        contentsUrl = nil
        contentReady = false
        let audioFilename = getDocumentsDirectory().appendingPathComponent("recording.m4a")
        try? FileManager().removeItem(at: audioFilename)
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]

        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder.record(forDuration: 10000)
        } catch {
            finishRecording(success: false)
            contentReady = false
        }
    }
    
    // Conform to delegate
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        finishRecording(success: flag)
    }
}
