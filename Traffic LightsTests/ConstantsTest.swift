//
//  ConstantsTest.swift
//  Traffic Lights
//
//  Created by CY Lim on 5/11/16.
//
//

import XCTest
import UIKit
@testable import Traffic_Lights

typealias traffic = Constants.TrafficLight

class ConstantsTest: XCTestCase {

	// MARK:- Set Up
	override func setUp() {
		super.setUp()
	}
	
	override func tearDown() {
		super.tearDown()
	}
	
	// MARK:- Tests
	
	// MARK: Duration
	// Make sure the duration for Red is the sum of amber and green
	// amber is always smaller than green
	func testRedDuration(){
		XCTAssertGreaterThan(traffic.red.duration(), traffic.amber.duration())
		XCTAssertGreaterThan(traffic.red.duration(), traffic.green.duration())
		XCTAssertEqual(traffic.red.duration(), traffic.amber.duration() + traffic.green.duration())
	}
	
	func testGreenDuration(){
		XCTAssertGreaterThan(traffic.green.duration(), traffic.amber.duration())
		XCTAssertLessThan(traffic.green.duration(), traffic.red.duration())
		XCTAssertEqual(traffic.green.duration(), traffic.red.duration() - traffic.amber.duration())
	}
	
	func testAmberDuration(){
		XCTAssertLessThan(traffic.amber.duration(), traffic.green.duration())
		XCTAssertLessThan(traffic.amber.duration(), traffic.red.duration())
		XCTAssertEqual(traffic.amber.duration(), traffic.red.duration() - traffic.green.duration())
	}
	
	// MARK: Getting Correct Image
	func testRedImage(){
		XCTAssertNotEqual(UIImage(traffic: .red), #imageLiteral(resourceName: "amber"))
		XCTAssertNotEqual(UIImage(traffic: .red), #imageLiteral(resourceName: "green"))
		XCTAssertEqual(UIImage(traffic: .red), #imageLiteral(resourceName: "red"))
	}
	
	func testGreenImage(){
		XCTAssertNotEqual(UIImage(traffic: .green), #imageLiteral(resourceName: "amber"))
		XCTAssertNotEqual(UIImage(traffic: .green), #imageLiteral(resourceName: "red"))
		XCTAssertEqual(UIImage(traffic: .green), #imageLiteral(resourceName: "green"))
	}
	
	func testAmberImage(){
		XCTAssertNotEqual(UIImage(traffic: .amber), #imageLiteral(resourceName: "green"))
		XCTAssertNotEqual(UIImage(traffic: .amber), #imageLiteral(resourceName: "red"))
		XCTAssertEqual(UIImage(traffic: .amber), #imageLiteral(resourceName: "amber"))
	}
}
