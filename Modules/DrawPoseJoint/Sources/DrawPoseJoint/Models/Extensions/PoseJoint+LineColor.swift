import Foundation
import CommonModels
import UIKit

extension PoseJoint {
    func getLineColorForDest(dest: PoseJoint) -> UIColor {
        return self.validationStatus == .correct && dest.validationStatus == .correct
            ? PoseJoint.Validation.correct.color.toUIColor()
            : PoseJoint.Validation.wrong.color.toUIColor()
    }
}
