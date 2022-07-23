//
//  ViewController.swift
//  SimpleTimer
//
//  Created by Ekko on 2022/07/20.
//

import UIKit

class ViewController: CommonViewController {
    
    var timer = Timer()
    var timerIsOn = false
    var timerStart = false
    let timerShape = CAShapeLayer()
    var seconds = 60 * 25
    
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ViewDidLoad")
        
        setUpStyle()
        createTrackCircle()
        createTimerCircle()
        
        
    }
    
    @IBAction func tappedStartButton(_ sender: Any) {
        
        if timerIsOn {
            // 타이머가 실행중인 경우
            // Pause Timer
            print("Timer is On: \(timerIsOn)")
            startButton.setImage(UIImage(systemName: "play",withConfiguration: boldConfig), for: .normal)
            
            timer.invalidate()
            pauseAnimation()
            
            timerIsOn = false
        } else {
            // 타이머가 정지 상태인 경우
            // Start or Restart Timer
            if timerStart {
                print("Timer is On: \(timerIsOn)")
                startButton.setImage(UIImage(systemName: "pause", withConfiguration: boldConfig), for: .normal)
                
                createTimer()
                restartAnimation()
                
                timerIsOn = true
            } else {
                print("Timer is On: \(timerIsOn)")
                startButton.setImage(UIImage(systemName: "pause", withConfiguration: boldConfig), for: .normal)
                
                createTimer()
                timerCircleAnimation(duration: TimeInterval(seconds))
                
                timerStart = true
                timerIsOn = true
            }
        }
    }
    
    func setUpStyle() {
        view.backgroundColor = .backgroundTeal
        timerLabel.textColor = .white
        timerLabel.text = String(seconds)
        timerLabel.font = UIFont.boldSystemFont(ofSize: 32)
        
        
        startButton.tintColor = .white
//        let startButtonImage = UIImage(systemName: "play",withConfiguration: boldConfig)
//        let pauseButtonImage = UIImage(systemName: "pause", withConfiguration: boldConfig)
        startButton.setImage(UIImage(systemName: "play", withConfiguration: boldConfig), for: .normal)
    }
}

extension ViewController {
    
    // Create Timer
    func createTimer() {
        timer.invalidate()
        timer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(fireTimer),
            userInfo: nil,
            repeats: true)
    }
    
    @objc func fireTimer() {
        seconds -= 1
        timerLabel.text = String(seconds)
        print(seconds)
        
        if(seconds == 0) {
            timer.invalidate()
        }
    }
    
    // Create Track Circle
    func createTrackCircle() {
        let circlePath = UIBezierPath(arcCenter: view.center,
                                      radius: 150,
                                      startAngle: -(.pi / 2),
                                      endAngle: .pi * 2,
                                      clockwise: true)
        
        let trackShape = CAShapeLayer()
        trackShape.path = circlePath.cgPath
        trackShape.fillColor = UIColor.clear.cgColor
        trackShape.lineWidth = 15
        trackShape.strokeColor = UIColor.lightGray.cgColor
        
        view.layer.addSublayer(trackShape)
    }
    
    // Create Timer Circle
    func createTimerCircle() {
        let circlePath = UIBezierPath(arcCenter: view.center,
                                      radius: 150,
                                      startAngle: CGFloat(-Double.pi / 2),
                                      endAngle: CGFloat(3 * Double.pi / 2),
                                      clockwise: true)
        //let timerShape = CAShapeLayer()
        timerShape.path = circlePath.cgPath
        timerShape.lineWidth = 15
        timerShape.lineCap = .round
        timerShape.strokeColor = UIColor.timerYellow.cgColor
        timerShape.strokeEnd = 0
        timerShape.fillColor = UIColor.clear.cgColor
        view.layer.addSublayer(timerShape)
    }
    
    func timerCircleAnimation(duration: TimeInterval) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = duration // 10초간 진행
        animation.toValue = 1.0
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        timerShape.add(animation, forKey: "animation")
    }
    
    func pauseAnimation() {
        print("Pause the Animation")
        let pausedTime = timerShape.convertTime(CACurrentMediaTime(), from: nil)
        timerShape.speed = 0.0
        timerShape.timeOffset = pausedTime
    }
    
    func restartAnimation() {
        print("Restart the Animation")
        let pausedTime = timerShape.timeOffset
        timerShape.speed = 1.0
        timerShape.timeOffset = 0.0
        timerShape.beginTime = 0.0
        
        let timeSincePause = timerShape.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        timerShape.beginTime = timeSincePause
    }
}

