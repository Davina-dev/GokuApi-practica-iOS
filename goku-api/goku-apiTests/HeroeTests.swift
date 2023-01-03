//
//  HeroeTests.swift
//  goku-apiTests
//
//  Created by Davina Medina Ramirez on 3/1/23.
//

import XCTest

final class HeroeTests: XCTestCase {

    var heroe: Heroe!
    
    override func setUp(){
      super.setUp()
        
        heroe = Heroe(id: "1",
                      name: "Goku",
                      photo: "https://www.keepcoding.io",
                      description: "Goku description",
                      favorite: false)
    }

    override func tearDown(){
        heroe = nil
      super.tearDown()
    }

    func test_heroe_id(){
        XCTAssertNotNil(heroe.id)
        XCTAssertEqual(heroe.id, "1")
        XCTAssertNotEqual(heroe.id, "8")
    }
    
    func test_heroe_name() {
        XCTAssertNotNil(heroe.name)
        XCTAssertEqual(heroe.name, "Goku")
        XCTAssertNotEqual(heroe.name, "Vegeta")
    }
    
    func test_heroe_photo() {
        let url = URL(string: heroe.photo)
        
        XCTAssertNotNil(heroe.photo)
        XCTAssertEqual(heroe.photo, "https://www.keepcoding.io")
        XCTAssertNotEqual(heroe.photo, "https://www.keepcoding.com")
        
        // TODO: - Check this one!
        XCTAssertNotNil(url?.absoluteURL)
    }
    
    func test_heroe_description() {
        XCTAssertNotNil(heroe.description)
        XCTAssertEqual(heroe.description, "Goku description")
        XCTAssertNotEqual(heroe.description, "Goku alwaySS win!!!")
    }
    
    func test_heroe_favorite() {
        XCTAssertNotNil(heroe.favorite)
        XCTAssertEqual(heroe.favorite, false)
    }


}
