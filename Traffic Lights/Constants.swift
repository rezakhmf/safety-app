//
//  Constants.swift
//  Traffic Lights
//
//  Created by Reza Farhani on 26/03/16.
//
//

import Foundation
import UIKit

struct Constants {
	
	static let AMBER_DURATION: Double = 5
	static let GREEN_DURATION: Double = 30
	
	enum TrafficLight: String {
		case red, amber, green
		
		func duration() -> Double {
			switch self {
			case .amber:
				return AMBER_DURATION
			case .green:
				return GREEN_DURATION
			case .red:
				return AMBER_DURATION + GREEN_DURATION
			}
		}
	}
	
	enum ButtonState: String {
		case Start, Stop
	}
}

extension UIImage {
	convenience init!(traffic: Color){
		self.init(named: traffic.rawValue)
	}
}
