import XCTest
import Model
import TestValues
@testable import PointMath

final class PointMathTests: XCTestCase {

    func testPointsNear() {
        let point1 = testPoint1
        let point2 = testPoint2
        let acceptedDiffX = abs(point1.x - point2.x)
        let acceptedDiffY = abs(point1.y - point2.y)

        let xNear = PointMath.isPointsNearEnougthX(first: point1, second: point2, value: acceptedDiffX)
        let yNear = PointMath.isPointsNearEnougthY(first: point1, second: point2, value: acceptedDiffY)

        XCTAssertTrue(xNear, "Points are not  near on X axis")
        XCTAssertTrue(yNear, "Points are not  near on Y axis")
    }

    func testPointsNotNear() {
        let point1 = testPoint1
        let point2 = testPoint2
        let acceptedDiffX = abs(point1.x - point2.x) - 0.01
        let acceptedDiffY = abs(point1.y - point2.y) - 0.01

        let xNear = PointMath.isPointsNearEnougthX(first: point1, second: point2, value: acceptedDiffX)
        let yNear = PointMath.isPointsNearEnougthY(first: point1, second: point2, value: acceptedDiffY)

        XCTAssertFalse(xNear, "Points are near on X axis, but shouldn't be")
        XCTAssertFalse(yNear, "Points are near on Y axis, but shouldn't be")
    }

    func testVectorCoorsCalculation() {
        let start = testPoint1
        let end = testPoint2
        let expected = CGPoint(x: 2, y: 6)

        let vectorCoors = PointMath.vectorBetweenPoints(first: start, second: end)
        XCTAssertEqual(vectorCoors, expected, "Wrong vector coors!")
    }

    func testVectorLength() {
        let testVectorCoors = CGPoint(x: 3, y: 4)
        let expectedLength: Double = 5
        let actualLength = PointMath.vectorLength(vectorCoors: testVectorCoors)
        XCTAssertEqual(actualLength, expectedLength, "Lengths not equal!")
    }
}

