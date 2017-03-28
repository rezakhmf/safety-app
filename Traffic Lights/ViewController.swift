//
//  ViewController.swift
//  Traffic Lights
//  Created by Reza Farhani on 26/03/16.
//

import UIKit

typealias TrafficLight = Constants.TrafficLight
typealias ButtonState = Constants.ButtonState

class ViewController: UIViewController {
	
	@IBOutlet weak var trafficLightImageView1: UIImageView!
	@IBOutlet weak var trafficLightImageView2: UIImageView!
	@IBOutlet weak var trafficLightImageView3: UIImageView!
	@IBOutlet weak var trafficLightImageView4: UIImageView!
	@IBOutlet weak var animatedButton: UIButton! {
		didSet{
			animatedButton.layer.masksToBounds = true
			animatedButton.layer.cornerRadius = 2.0
		}
	}
	
	var vertical: Traffic!
	var horizontal: Traffic!
	
	var isVertical: Bool = true
	var animated: Bool = false
	var timer: Timer?
	var dispatchTask: DispatchWorkItem?

    override func viewDidLoad() {
        super.viewDidLoad()
		setTrafficLightImageViewDirection()
		groupTrafficLightByDirection()
		
		dispatchTask = DispatchWorkItem { self.changeLight() }
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		
		stopAnimating() // in case if GCD or Timer running in background
	}
	
	@IBAction func animated(_ sender: Any) {
		animated ? stopAnimating() : startAnimating()
	}
}

// MARK: Main Functionalites, start of stop animating the traffic light
extension ViewController {
	func startAnimating() {
		animated = true
		changeButton(state: .Stop, color: .red)
		
		timer = createTimer(time: .green, selector: #selector(animateTraffic))
	}
	
	func stopAnimating() {
		
		dispatchTask?.cancel()
		timer?.invalidate()
		
		// To Default State
		
		vertical.changeTrafficLight(to: .green)
		
		isVertical = true
		animated = false
		changeButton(state: .Start, color: .blue)
	}
	
	func animateTraffic(){
		// Change Green Light to Yellow
		isVertical ? vertical.changeTrafficLight() : horizontal.changeTrafficLight()
		
		// Change Yellow Light to Red, Red Light to Green
		DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(Int(TrafficLight.amber.duration())), execute: dispatchTask!)
		
		// Red Duration is Amber + Green Duration, which is the total duration
		timer = createTimer(time: .red, selector: #selector(animateTraffic))
	}
	
	
	func changeLight(){
		isVertical = !isVertical
		vertical.changeTrafficLight()
		horizontal.changeTrafficLight()
	}
	
	func createTimer(time: TrafficLight, selector: Selector) -> Timer {
		return Timer.scheduledTimer(timeInterval: time.duration(), target: self, selector: selector, userInfo: nil, repeats: false)
	}
}

// MARK: Direction of images
extension ViewController {
	// Changing the button title and color
	func changeButton(state: ButtonState, color: UIColor){
		UIView.animate(withDuration: 0.5){
			self.animatedButton.setTitle(state.rawValue, for: .normal)
			self.animatedButton.backgroundColor = color
		}
	}
	
		func transfrom(for imageView: UIImageView, degree: Double) {
		imageView.transform = CGAffineTransform(rotationAngle: CGFloat(degree * M_PI / 180))
	}
	
	func setTrafficLightImageViewDirection() {
		transfrom(for: trafficLightImageView1, degree: 90)
		transfrom(for: trafficLightImageView2, degree: 180)
		transfrom(for: trafficLightImageView4, degree: -90)
	}
	
	
	func groupTrafficLightByDirection() {
		horizontal = Traffic([trafficLightImageView1, trafficLightImageView4])
		vertical = Traffic([trafficLightImageView2, trafficLightImageView3])
	}
}

