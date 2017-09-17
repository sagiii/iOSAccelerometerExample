//
//  GraphView.swift
//  iOSAccelerometerExample
//
//  Created by 鷺坂隆志 on 2017/09/17.
//  Copyright © 2017年 Maxim Bilan. All rights reserved.
//

import UIKit

class GraphView: UIView {
    
    var data:[Double] = []
    
    override func draw(_ rect: CGRect) {
        let data_ = data
        let MAGNIFY: Double = 3000
        let ORG_X: CGFloat = 0
        let ORG_Y: CGFloat = 0
        /*
        let line = UIBezierPath()
        line.move(to: CGPoint(x: ORG_X, y: ORG_Y))
        if (data_.count > 0) {
            for i in 0...(data_.count - 1) {
                line.addLine(to: CGPoint(x: ORG_X + CGFloat(Float(i) / Float(data_.count)) * rect.width, y: ORG_Y + CGFloat(data_[i] * MAGNIFY)))
            }
        }
        UIColor.blue.setStroke()
        line.lineWidth = 1
        line.stroke();
        */
        if (data_.count > 0) {
            UIColor.blue.setFill()
            for i in 0...(data_.count - 1) {
                let x = Double(i) / Double(data_.count) * Double(rect.width)
                let y = data_[i] * MAGNIFY
                let rect = UIBezierPath(rect: CGRect(x: x, y: 0, width: Double(rect.width) / Double(data_.count), height: y))
                rect.fill()
            }
        }
    }

}
