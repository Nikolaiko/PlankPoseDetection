import Foundation

public enum PointMath {
    public static func isPointsNearEnougthY(
        first: CGPoint,
        second: CGPoint,
        value: Double
    ) -> Bool {
        abs(first.y - second.y) <= value
    }

    public static func isPointsNearEnougthX(
        first: CGPoint,
        second: CGPoint,
        value: Double
    ) -> Bool {
        abs(first.x - second.x) <= value
    }
}
