//
//  ViewController.swift
//  SimpleTimer
//
//  Created by Ekko on 2022/07/20.
//

import UIKit

class ViewController: UIViewController {
    
    var timerText: Int = 0
    let timerShape = CAShapeLayer()
    
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ViewDidLoad")
        createTrackCircle()
        createTimerCircle()
            }
    
    @IBAction func tappedStartButton(_ sender: Any) {
        timerText = 0
        createTimer()
        timerCircleAnimation()
    }
}

extension ViewController {
    
    // Create Timer
    func createTimer() {
        let timer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(fireTimer),
            userInfo: nil,
            repeats: true)
        
        //timer.tolerance = 10
        
    }
    
    @objc func fireTimer() {
        timerText += 1
        DispatchQueue.main.async {
            self.timerLabel.text = String(self.timerText)
        }
        
        print(timerText)
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
                                      startAngle: -(.pi / 2),
                                      endAngle: .pi * 2,
                                      clockwise: true)
        //let timerShape = CAShapeLayer()
        timerShape.path = circlePath.cgPath
        timerShape.lineWidth = 15
        timerShape.strokeColor = UIColor.blue.cgColor
        timerShape.strokeEnd = 1
        timerShape.fillColor = UIColor.clear.cgColor
        view.layer.addSublayer(timerShape)
    }
    
    func timerCircleAnimation() {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = 0
        animation.duration = 10 // 10초간 진행
        
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        
        timerShape.add(animation, forKey: "animation")
    }
}

