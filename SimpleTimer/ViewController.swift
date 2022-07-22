//
//  ViewController.swift
//  SimpleTimer
//
//  Created by Ekko on 2022/07/20.
//

import UIKit

class ViewController: UIViewController {
    
    var timer = Timer()
    var timerIsOn = false
    let timerShape = CAShapeLayer()
    var seconds = 60
    
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ViewDidLoad")
        
        createTrackCircle()
        createTimerCircle()
    }
    
    @IBAction func tappedStartButton(_ sender: Any) {
        if timerIsOn {
            
            timerIsOn = false
        } else {
            timerIsOn = true
        }
        createTimer()
        timerCircleAnimation(duration: TimeInterval(seconds))
        
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
        timerShape.strokeColor = UIColor.blue.cgColor
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
}

