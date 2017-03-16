//
//  ViewController.swift
//  SpeechToTextDemo
//
//  Created by andyron on 2017/3/16.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit
import Speech

class ViewController: UIViewController, SFSpeechRecognizerDelegate {

    @IBOutlet var textView: UITextView!
    @IBOutlet var microphoneButton: UIButton!
    
    // 构建特定语种的语音识别器 （https://gist.github.com/jacobbubu/1836273）
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "zh_Hans_CN"))
    
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?  //识别请求
    private var recognitionTask: SFSpeechRecognitionTask?       // 提供识别请求的结果
    private let audioEngine = AVAudioEngine()       //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 默认情况下取消按钮的点击功能，知道语音识系统可用情况后
        microphoneButton.isEnabled = false
        speechRecognizer?.delegate = self
        
        // 遍历授权结果
        SFSpeechRecognizer.requestAuthorization{
            (authStatus) in
            var isButtionEnabled = false
            
            switch authStatus {
            case .authorized:
                isButtionEnabled = true
            case .denied:
                isButtionEnabled = false
                print("用户拒绝接受语音识别")
            case .notDetermined:
                isButtionEnabled = false
                print("语音识别功能没有经过认可")
            case .restricted:
                isButtionEnabled = false
                print("当前设备不能语音识别")
            
            }
            self.microphoneButton.isEnabled = isButtionEnabled
        }
        startRecording()
    }

    @IBAction func microphoneTapped(_ sender: AnyObject) {
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
            microphoneButton.isEnabled = false
            microphoneButton.setTitle("Start Recording", for: .normal)
        } else {
            startRecording()
            microphoneButton.setTitle("Stop Recording", for: .normal)
        }
    }
    
    func startRecording() {
        if recognitionTask != nil {
            recognitionTask?.cancel()
            recognitionTask = nil
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSessionCategoryRecord)
            try audioSession.setMode(AVAudioSessionModeMeasurement)
            try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
        } catch {
            print("audioSession的属性设置失败")
        }
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        guard let inputNode = audioEngine.inputNode else {
            fatalError("Audio engine has no input node")
        }
        guard let recognitionRequest = recognitionRequest else {
            fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
        }
        
        recognitionRequest.shouldReportPartialResults = true
        
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest, resultHandler: {
            (result, error) in
            var isFinal = false
            if result != nil {
                self.textView.text = result?.bestTranscription.formattedString
                isFinal = (result?.isFinal)!
            }
            
            if error != nil || isFinal {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
                
                self.microphoneButton.isEnabled = true
            }
        })
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        
        do {
            try audioEngine.start()
        } catch {
            print("audioEngine couldn't start beacause of an error.")
        }
        
        textView.text = "Say something, I'm listening!"
    }

    
    //MARK: - SFSpeechRecognizerDelegate
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if available {
            microphoneButton.isEnabled = true
        } else {
            microphoneButton.isEnabled = false
        }
    }

}

