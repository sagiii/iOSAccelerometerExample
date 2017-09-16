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
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		motionManager.startAccelerometerUpdates()
		motionManager.startGyroUpdates()
		motionManager.startMagnetometerUpdates()
		motionManager.startDeviceMotionUpdates()
		
		timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(ViewController.update), userInfo: nil, repeats: true)
	}

	func update() {
		if let accelerometerData = motionManager.accelerometerData {
			print(accelerometerData)
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
