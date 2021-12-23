//
//  CircularProgressBarView.swift
//  Questionnaire
//
//  Created by Ilya Turin on 20.12.2021.
//

import UIKit

final class CircularProgressBarView: NLView {
    
    // MARK: - Locals
    
    private enum Locals {
            
        static let circleWidth: CGFloat = 20
        static let radius: CGFloat = 80
    }
    
    
    // MARK: - Properties
    
    var diameter: CGFloat {
        Locals.radius * 2
    }
    
    private var timer: Timer?
    private var timerCounter = 0
    private var duration: Double = 0
    private var percentage: Double = 0
    
    private let circleForegroundLayer = CAShapeLayer()
    private let circleBackgroundLayer = CAShapeLayer()
    private let pulsatingLayer = CAShapeLayer()
    private let percentageCenterLabel = UILabel()
    
    private var pathCenter: CGPoint {
        convert(center, from: superview)
    }
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        drawPulsatingLayer()
        drawSelf()
    }
    
    
    // MARK: - Public methods
    
    func start(duration: Double, percentage: Double) {
        
        self.duration = duration
        self.percentage = percentage
        
        let delay = duration / (percentage * 100)
        let progressAnimation = CABasicAnimation(keyPath: "strokeEnd")
        progressAnimation.duration = duration
        progressAnimation.fromValue = 0
        progressAnimation.toValue = percentage
        progressAnimation.fillMode = .forwards
        progressAnimation.isRemovedOnCompletion = false
        circleForegroundLayer.add(progressAnimation, forKey: "progressAnim")
        animatePulsatingLayer()
        
        timer = Timer.scheduledTimer(
            timeInterval: delay,
            target: self,
            selector: #selector(updateLabel),
            userInfo: nil,
            repeats: true
        )
        
        if let timer = timer {
            RunLoop.current.add(timer, forMode: .common)
        }
    }
    
    
    // MARK: - Drawing
    
    private func drawSelf() {
            
        let startAngle = (-CGFloat.pi/2)
        let endAngle = 2 * CGFloat.pi + startAngle
        let circularPath = UIBezierPath(
            arcCenter: pathCenter,
            radius: Locals.radius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: true)
        
        circleBackgroundLayer.path = circularPath.cgPath
        circleBackgroundLayer.fillColor = UIColor.white.cgColor
        circleBackgroundLayer.lineCap = .round
        circleBackgroundLayer.lineWidth = Locals.circleWidth
        circleBackgroundLayer.strokeEnd = 1.0
        circleBackgroundLayer.strokeColor = Colors.mainSkyBlueColor()?.cgColor
        layer.addSublayer(circleBackgroundLayer)
        
        circleForegroundLayer.path = circularPath.cgPath
        circleForegroundLayer.fillColor = UIColor.clear.cgColor
        circleForegroundLayer.lineCap = .round
        circleForegroundLayer.lineWidth = Locals.circleWidth
        circleForegroundLayer.strokeEnd = 0
        circleForegroundLayer.strokeColor = Colors.mainBlueColor()?.cgColor
        layer.addSublayer(circleForegroundLayer)
        
        addSubview(percentageCenterLabel)
        percentageCenterLabel.autoCenterInSuperview()
        percentageCenterLabel.textColor = .black
        percentageCenterLabel.text = "0%"
        percentageCenterLabel.font = UIFont(name: MainFont.extraBold, size: 24)
        percentageCenterLabel.textColor = Colors.mainBlueColor()
    }
    
    private func drawPulsatingLayer() {
        
        let circularPath = UIBezierPath(arcCenter: .zero,
                                        radius: Locals.radius,
                                        startAngle: 0,
                                        endAngle: 2 * CGFloat.pi,
                                        clockwise: true)
        
        pulsatingLayer.path = circularPath.cgPath
        pulsatingLayer.strokeColor = UIColor.clear.cgColor
        pulsatingLayer.lineWidth = Locals.circleWidth
        pulsatingLayer.fillColor = Colors.mainBlueColor()?.withAlphaComponent(0.1).cgColor
        pulsatingLayer.lineCap = CAShapeLayerLineCap.round
        pulsatingLayer.position = pathCenter
        self.layer.addSublayer(pulsatingLayer)
    }
    
    private func animatePulsatingLayer() {
        
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.toValue = 1.3
        animation.duration = 0.8
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
        pulsatingLayer.add(animation, forKey: "pulsing")
    }
    
    
    // MARK: - Actions
    
    @objc private func updateLabel() {
        
        let percents = percentage * 100
        
        if (timerCounter == Int(percents)) {
            self.percentageCenterLabel.text = "\(String(Int(percents)))%"
            self.pulsatingLayer.removeAnimation(forKey: "pulsing")
            
            if let timer = timer {
                timer.invalidate()
            }
            
            return
        }
       
        timerCounter += 1
        percentageCenterLabel.text = "\(String(timerCounter))%"
    }
    
}
