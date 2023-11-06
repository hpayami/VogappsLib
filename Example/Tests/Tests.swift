import UIKit
import XCTest
import VogappsLib
import PromiseKit
import ImageIO

class Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure() {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testMetadataIsSuccessful(){
        
        let myExpectation = expectation(description: "longRunningFunction")
        
        let image = UIImage(named: "IMG_0087.JPG")!
        
        let url = Bundle.main.url(forResource: "IMG_0087", withExtension: "JPG")
        let imageSource = CGImageSourceCreateWithURL(url! as CFURL, nil)
        let imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSource!, 0, nil) as! [String: Any]?
        
       _ = image.copyToDocuments(metadata: imageProperties).done { result in
            myExpectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 3){ error in
            XCTAssert(true)
        }
        
    }
    
    
    func testDelay(){
        let myExpectation = expectation(description: "longRunningFunction")
        
        var result = false
        delay(3){
            result = true
            myExpectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 3.5) { error in
            if error != nil {
                XCTAssertTrue(false, "timeout")
            }
            
            
            XCTAssertTrue(result, "result is not true")
        }
    }
    
}
