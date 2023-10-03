import Model
import Foundation

public enum LineMath {
    public static func calculateLineParameters(point1: CGPoint, point2: CGPoint) -> LineParameters {
        let aCoff = (point2.y - point1.y) / (point2.x - point1.x)
        let bCoff = point1.y - aCoff * point1.x
        return LineParameters(a: aCoff, b: bCoff)
    }
}
