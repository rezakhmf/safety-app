//
//  TrafficTests.swift
//  Traffic Lights
//
//  Created by Reza Farhani on 28/03/16.
//
//

import XCTest
@testable import Traffic_Lights

typealias Color = Constants.TrafficLight

class TrafficTests: XCTestCase {
	// MARK: - Properties
	var traffic:Traffic!
	var imageView1: UIImageView!
	var imageView2: UIImageView!
	
	// MARK: - Set Up
    override func setUp() {
        super.setUp()
		imageView1 = UIImageView.init()
		imageView2 = UIImageView.init()
		traffic = Traffic([imageView1, imageView2])
    }
    
    override func tearDown() {
		traffic = nil
		imageView1 = nil
		imageView2 = nil
        super.tearDown()
    }
	
	// MARK: - Tests
	func testTrafficInitializeFromImageViewArray() {
		XCTAssertNotNil((traffic), "Successful Initialized")
	}
	
	
	// MARK: Change the color to the next color should be appear
	func testTrafficChangeColorToGreen() {
		traffic.changeTrafficLight(to: .red)
		traffic.changeTrafficLight()
		XCTAssertEqual(traffic.getTrafficColor(), Color.green)
		XCTAssertNotEqual(traffic.getTrafficColor(), Color.red)
		XCTAssertNotEqual(traffic.getTrafficColor(), Color.amber)
	}
	
	func testTrafficChangeColorToAmber() {
		traffic.changeTrafficLight(to: .green)
		traffic.changeTrafficLight()
		XCTAssertEqual(traffic.getTrafficColor(), Color.amber)
		XCTAssertNotEqual(traffic.getTrafficColor(), Color.red)
		XCTAssertNotEqual(traffic.getTrafficColor(), Color.green)
	}
	
	func testTrafficChangeColorToRed() {
		traffic.changeTrafficLight(to: .amber)
		traffic.changeTrafficLight()
		XCTAssertEqual(traffic.getTrafficColor(), Color.red)
		XCTAssertNotEqual(traffic.getTrafficColor(), Color.amber)
		XCTAssertNotEqual(traffic.getTrafficColor(), Color.green)
	}
}
