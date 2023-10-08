import XCTest
import Model
import TestValues
@testable import LineMath

final class LineMathTests: XCTestCase {
    
    func testLineParametersCalculation() {
        let point1 = testPoint1
        let point2 = testPoint2

        let parameters = LineMath.calculateLineParameters(point1: point1, point2: point2)

        let expectedParameters = LineParameters(a: 3, b: -1)
        XCTAssertEqual(parameters, expectedParameters, "Line Parameters not equal")
    }

    func testNearestPointCalculation() {
        let lineParameters = testLine1
        let startPoint = testPoint3

        let actualNearestPoint = LineMath.findNearestPointFromStartOnLine(
            line: lineParameters,
            start: startPoint
        )
        let expectedPoint = CGPoint(x: 180.125, y: 409.625)
        XCTAssertEqual(expectedPoint, actualNearestPoint, "Points are not equal!")
    }
}
