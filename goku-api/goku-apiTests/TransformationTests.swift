//
//  TransformationTests.swift
//  goku-apiTests
//
//  Created by Davina Medina Ramirez on 3/1/23.
//

import XCTest


final class TransformationTests: XCTestCase {
    
    var transformation: Transformation!
    
    override func setUp()  {
        super.setUp()
        transformation = Transformation(id: "13",
                                        name: "Super saiyan",
                                        photo: "https://www.keepcoding.io",
                                        description: "This is the real one")
    }
    
    override func tearDown() {
        transformation = nil
        super.tearDown()
    }
    func testTransformationId() {
        XCTAssertNotNil(transformation.id)
        XCTAssertEqual(transformation.id, "13")
        XCTAssertNotEqual(transformation.id, "7")
    }
    
    func testTransformationName() {
        XCTAssertNotNil(transformation.name)
        XCTAssertEqual(transformation.name, "Super saiyan")
        XCTAssertNotEqual(transformation.name, "Super saiyan Blue")
    }
    
    func testTransformationPhoto() {
        let url = URL(string: transformation.photo)
        
        XCTAssertNotNil(transformation.photo)
        XCTAssertEqual(transformation.photo, "https://www.keepcoding.io")
        XCTAssertNotEqual(transformation.photo, "https://www.keepcoding.com")
        
        // TODO: - Check this one!
        XCTAssertNotNil(url?.absoluteURL)
    }
    
    func testTransformationDescription() {
        XCTAssertNotNil(transformation.description)
        XCTAssertEqual(transformation.description, "This is the real one")
        XCTAssertNotEqual(transformation.description, "This is the real four")
    }
    
    
    
}
