//
//  LineGraphView.swift
//  iOSAccelerometerExample
//
//  Created by 鷺坂隆志 on 2017/09/18.
//  Copyright © 2017年 Maxim Bilan. All rights reserved.
//

import UIKit
import CoreMotion

class LineGraphView: UIView {
    
    var data:[CMAccelerometerData] = []

    override func draw(_ rect: CGRect) {
        var data_ = data
        let MAGNIFY: Double = Double(rect.height / 3)
        let ORG_X: CGFloat = 0
        let ORG_Y: CGFloat = rect.height / 2
        if (data_.count > 0) {
            var line = UIBezierPath()
            line.move(to: CGPoint(x: ORG_X, y: ORG_Y))
            line.addLine(to: CGPoint(x: ORG_X + rect.width, y: ORG_Y))
            UIColor.black.setStroke()
            line.lineWidth = 1
            line.stroke()
            
            line = UIBezierPath()
            line.move(to: CGPoint(x: ORG_X, y: ORG_Y))
            for i in 0...(data_.count - 1) {
                line.addLine(to: CGPoint(x: ORG_X + CGFloat(Float(i) / Float(data_.count)) * rect.width, y: ORG_Y + CGFloat(data_[i].acceleration.x * MAGNIFY)))
            }
            UIColor.red.setStroke()
            line.lineWidth = 1
            line.stroke();

            line = UIBezierPath()
            line.move(to: CGPoint(x: ORG_X, y: ORG_Y))
            for i in 0...(data_.count - 1) {
                line.addLine(to: CGPoint(x: ORG_X + CGFloat(Float(i) / Float(data_.count)) * rect.width, y: ORG_Y + CGFloat(data_[i].acceleration.y * MAGNIFY)))
            }
            UIColor.green.setStroke()
            line.lineWidth = 1
            line.stroke();

            line = UIBezierPath()
            line.move(to: CGPoint(x: ORG_X, y: ORG_Y))
            for i in 0...(data_.count - 1) {
                line.addLine(to: CGPoint(x: ORG_X + CGFloat(Float(i) / Float(data_.count)) * rect.width, y: ORG_Y + CGFloat(data_[i].acceleration.z * MAGNIFY)))
            }
            UIColor.blue.setStroke()
            line.lineWidth = 1
            line.stroke();
        }
    }

}
