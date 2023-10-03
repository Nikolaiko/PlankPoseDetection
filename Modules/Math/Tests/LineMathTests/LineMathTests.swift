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
}
