import UIKit
import CommonModels

public struct DrawPoseJoint {
    public var drawPointsOnImage: ImageDrawer
    public var drawPointsOnTransparentImage: ImageDrawer

    init(drawPointsOnImage: @escaping ImageDrawer,
         drawPointsOnTransparentImage: @escaping ImageDrawer) {
        self.drawPointsOnImage = drawPointsOnImage
        self.drawPointsOnTransparentImage = drawPointsOnTransparentImage
    }
}
