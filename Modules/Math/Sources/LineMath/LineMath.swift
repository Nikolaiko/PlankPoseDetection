import Model
import Foundation

public enum LineMath {
    public static func calculateLineParameters(point1: CGPoint, point2: CGPoint) -> LineParameters {
        let aCoff = (point2.y - point1.y) / (point2.x - point1.x)
        let bCoff = point1.y - aCoff * point1.x
        return LineParameters(a: aCoff, b: bCoff)
    }

    public static func findNearestPointFromStartOnLine(line: LineParameters, start: CGPoint) -> CGPoint {
        let nearestX = (start.x + line.a * start.y - line.a * line.b) / (line.a * line.a + 1)
        let nearestY = line.a * nearestX + line.b
        return CGPoint(x: nearestX, y: nearestY)
    }
}
