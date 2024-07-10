import Foundation

public enum PointMath {
    public static func isPointsNearEnougthY(first: CGPoint, second: CGPoint, value: Double) -> Bool {
        abs(first.y - second.y) <= value
    }

    public static func isPointsNearEnougthX(first: CGPoint, second: CGPoint, value: Double) -> Bool {
        abs(first.x - second.x) <= value
    }

    public static func vectorBetweenPoints(first: CGPoint, second: CGPoint) -> CGPoint {
        CGPoint(x: second.x - first.x, y: second.y - first.y)
    }

    public static func vectorLength(vectorCoors: CGPoint) -> Double {
        sqrt(pow(vectorCoors.x, 2) + pow(vectorCoors.y, 2))
    }
}
