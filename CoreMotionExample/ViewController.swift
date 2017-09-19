//
//  ViewController.swift
//  CoreMotionExample
//
//  Created by Maxim Bilan on 1/21/16.
//  Copyright © 2016 Maxim Bilan. All rights reserved.
//

import UIKit
import CoreMotion
import Surge

class ViewController: UIViewController {

	let motionManager = CMMotionManager()
	var timer: Timer!
    var accArray: [CMAccelerometerData] = []
    let FFT_LENGTH = 256
    var graphview: GraphView?
    var linegraphview: LineGraphView?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
        // Screen Size の取得
        let screenWidth = self.view.bounds.width
        let screenHeight = self.view.bounds.height
        
        graphview = GraphView(frame: CGRect(x: screenWidth * 0.1, y: screenHeight * 0.1, width: screenWidth * 0.8, height: screenHeight * 0.5))
        linegraphview = LineGraphView(frame: CGRect(x: screenWidth * 0.1, y: screenHeight * 0.65, width: screenWidth * 0.8, height: screenHeight * 0.3))
        self.view.addSubview(graphview!)
        self.view.addSubview(linegraphview!)
        graphview?.clearsContextBeforeDrawing = true
        graphview?.backgroundColor = UIColor.gray
        linegraphview?.clearsContextBeforeDrawing = true
        linegraphview?.backgroundColor = UIColor.gray

        motionManager.startAccelerometerUpdates()
		motionManager.startGyroUpdates()
		motionManager.startMagnetometerUpdates()
		motionManager.startDeviceMotionUpdates()
		
		timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(ViewController.update), userInfo: nil, repeats: true)
	}

	func update() {
		if let accelerometerData = motionManager.accelerometerData {
			//print(accelerometerData)
            accArray.append(accelerometerData)
            if (accArray.count == FFT_LENGTH) {
                var m: Matrix<Double> = Matrix<Double>(rows: 3, columns: accArray.count, repeatedValue: 0.0)
                for i in 0...accArray.count - 1 {
                    m[0, i] = accArray[i].acceleration.x
                    m[1, i] = accArray[i].acceleration.y
                    m[2, i] = accArray[i].acceleration.z
                }
                m[row: 0] = fft(m[row: 0])
                m[row: 1] = fft(m[row: 1])
                m[row: 2] = fft(m[row: 2])
                let FFT_OUTPUT_LENGTH = FFT_LENGTH / 2
                var a: [Double] = [Double](repeating: 0.0, count: FFT_OUTPUT_LENGTH)
                for i in 0...(FFT_OUTPUT_LENGTH - 1) {
                    a[i] = sqrt(m[column: i] • m[column: i])
                }
                //print(a)
                a.removeFirst()
                graphview?.data = a
                linegraphview?.data = accArray
                graphview?.setNeedsDisplay()
                linegraphview?.setNeedsDisplay()
                // next
                accArray.removeFirst()
            }
		}
        /*
		if let gyroData = motionManager.gyroData {
			print(gyroData)
		}
		if let magnetometerData = motionManager.magnetometerData {
			print(magnetometerData)
		}
		if let deviceMotion = motionManager.deviceMotion {
			print(deviceMotion)
		}
         */
	}
	
}
