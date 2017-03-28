//
//  TrafficDirection.swift
//  Traffic Lights
//
//  Created by Reza Farhani on 28/03/16.
//
//

import Foundation
import UIKit

typealias Color = Constants.TrafficLight

struct Traffic {
	internal let trafficImageView: [UIImageView]
	
	init(_ trafficImageView:[UIImageView]){
		self.trafficImageView = trafficImageView
	}
	
	// Manually set the traffic light color
	func changeTrafficLight(to color: Color){
		trafficImageView.forEach{ $0.image = UIImage(traffic: color) }
	}
	
	// Change the Traffic Light Color according to the correct order
	func changeTrafficLight(){
		let color = newTrafficColor(color: getTrafficColor())
		trafficImageView.forEach{ $0.image = UIImage(traffic: color) }
	}
	
	// Get Current Traffic Color
	internal func getTrafficColor() -> Color {
		let view = trafficImageView[0]
		switch view.image! {
		case #imageLiteral(resourceName: "green"):
			return .green
		case #imageLiteral(resourceName: "amber"):
			return .amber
		default:
			return .red
		}
	}
	
	// Change Traffic Light Color in correct order
	private func newTrafficColor(color: Color) -> Color {
		switch color {
		case .green:
			return .amber
		case .amber:
			return .red
		case .red:
			return .green
		}
	}
}
