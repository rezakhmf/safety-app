//
//  Traffic_LightsTests.swift
//  Traffic LightsTests
//

import XCTest
import UIKit
@testable import Traffic_Lights

typealias TrafficLight = Constants.TrafficLight
typealias ButtonState = Constants.ButtonState

class ViewControllerTests: XCTestCase {

	// MARK: - Properties
	var vc: ViewController!
	
	// MARK: - Set Up
	override func setUp() {
		super.setUp()
		
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		vc = storyboard.instantiateInitialViewController() as! ViewController
		
		UIApplication.shared.keyWindow?.rootViewController = vc
		
		XCTAssertNotNil(vc.view)
	}
	
	override func tearDown() {
		super.tearDown()
	}
	
	// MARK: - Tests
	// MARK: Check if all the image in Array have same status
	func testTrafficVerticalDirectionHaveSameImage(){
		vc.vertical.changeTrafficLight(to: .green)
		XCTAssertEqual(vc.trafficLightImageView2.image, UIImage(traffic: .green))
		XCTAssertEqual(vc.trafficLightImageView2.image, vc.trafficLightImageView3.image)
		
		vc.vertical.changeTrafficLight(to: .amber)
		XCTAssertEqual(vc.trafficLightImageView2.image, UIImage(traffic: .amber))
		XCTAssertEqual(vc.trafficLightImageView2.image, vc.trafficLightImageView3.image)
		
		vc.vertical.changeTrafficLight(to: .red)
		XCTAssertEqual(vc.trafficLightImageView2.image, UIImage(traffic: .red))
		XCTAssertEqual(vc.trafficLightImageView2.image, vc.trafficLightImageView3.image)
	}
	
	func testTrafficHorizontalDirectionHaveSameImage(){
		vc.horizontal.changeTrafficLight(to: .green)
		XCTAssertEqual(vc.trafficLightImageView1.image, UIImage(traffic: .green))
		XCTAssertEqual(vc.trafficLightImageView1.image, vc.trafficLightImageView4.image)
		
		vc.horizontal.changeTrafficLight(to: .amber)
		XCTAssertEqual(vc.trafficLightImageView1.image, UIImage(traffic: .amber))
		XCTAssertEqual(vc.trafficLightImageView1.image, vc.trafficLightImageView4.image)
		
		vc.horizontal.changeTrafficLight(to: .red)
		XCTAssertEqual(vc.trafficLightImageView1.image, UIImage(traffic: .red))
		XCTAssertEqual(vc.trafficLightImageView1.image, vc.trafficLightImageView4.image)
	}
	
	func testTrafficDirectionImageAfterChangingLight(){
		// Due to there is three different color, run the test three time
		vc.changeLight()
		XCTAssertNotEqual(vc.vertical.getTrafficColor(), vc.horizontal.getTrafficColor())
		
		vc.changeLight()
		XCTAssertNotEqual(vc.vertical.getTrafficColor(), vc.horizontal.getTrafficColor())
		
		vc.changeLight()
		XCTAssertNotEqual(vc.vertical.getTrafficColor(), vc.horizontal.getTrafficColor())
	}
	
	// MARK: Button State
	func testChangeButtonStateToStart(){
		vc.changeButton(state: .Start, color: .blue)
		XCTAssertEqual(vc.animatedButton.currentTitle, "Start")
		XCTAssertEqual(vc.animatedButton.backgroundColor, .blue)
		
		XCTAssertNotEqual(vc.animatedButton.currentTitle, "Stop")
		XCTAssertNotEqual(vc.animatedButton.backgroundColor, .red)
	}
	
	func testChangeButtonStateToStop(){
		vc.changeButton(state: .Stop, color: .red)
		XCTAssertEqual(vc.animatedButton.currentTitle, "Stop")
		XCTAssertEqual(vc.animatedButton.backgroundColor, .red)
		
		
		XCTAssertNotEqual(vc.animatedButton.currentTitle, "Start")
		XCTAssertNotEqual(vc.animatedButton.backgroundColor, .blue)
	}
	
	// MARK: Flow
	func testStartAndStopAnimating(){
		// Start and Stop Animating
		vc.animated(vc.animatedButton)
		XCTAssertTrue(vc.animated)
		vc.animated(vc.animatedButton)
		XCTAssertFalse(vc.animated)
	}
	
	// Testing the main flow without using Timer and GCD
	func testAnimateTraffic(){
		vc.animateTraffic()
		vc.isVertical ? XCTAssertEqual(vc.vertical.getTrafficColor(), .amber)
			: XCTAssertEqual(vc.horizontal.getTrafficColor(), .amber)
		vc.stopAnimating()
		
		// changeLight() is the function to change isVertical and related variables
		vc.changeLight()
		vc.animateTraffic()
		vc.isVertical ? XCTAssertEqual(vc.vertical.getTrafficColor(), .amber)
			: XCTAssertEqual(vc.horizontal.getTrafficColor(), .amber)
		vc.stopAnimating()
	}
}
