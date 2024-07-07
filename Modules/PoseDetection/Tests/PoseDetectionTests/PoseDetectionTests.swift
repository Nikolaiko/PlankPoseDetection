import XCTest
import Dependencies

@testable import PoseDetection

final class PoseDetectionTests: XCTestCase {

    private let detector = PoseDetector.liveValue    

    func testJointsCount() {
        guard let cgImage = testCGImage else {
            XCTFail("No test image found")
            return
        }
        
        let joints = detector.detectPoses(cgImage)
        XCTAssertEqual(joints.count, testImageExpectedJointsCount)
    }

    func testDetectedJointsType() {
        guard let cgImage = testCGImage else {
            XCTFail("No test image found")
            return
        }

        let joints = detector.detectPoses(cgImage)
        for currentJoint in joints {
            XCTAssertTrue(testImageExpectedTypes.contains(currentJoint.key))
        }
    }
}
