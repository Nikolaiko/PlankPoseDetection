import Dependencies
import UIKit
import CommonModels

extension DrawPoseJoint: DependencyKey {
    static public var liveValue: Self {
        let tryToDrawLine: DrawLineHelper = {context, source, dest in
            if let source = source, let dest = dest {
                let lineColor = source.getLineColorForDest(dest: dest)
                context.setStrokeColor(lineColor.cgColor)
                context.setFillColor(lineColor.cgColor)
                context.move(to: source.position)
                context.addLine(to: dest.position)
                context.strokePath()

            }
        }

        return Self { sourceImage, points in
            let cgSourceImage = sourceImage.cgImage!
            let dstImageSize = CGSize(width: cgSourceImage.width, height: cgSourceImage.height)
            let dstImageFormat = UIGraphicsImageRendererFormat()
            dstImageFormat.scale = 1

            let renderer = UIGraphicsImageRenderer(
                size: dstImageSize,
                format: dstImageFormat
            )

            let dstImage = renderer.image { rendererContext in
                rendererContext.cgContext.saveGState()
                rendererContext.cgContext.scaleBy(x: 1.0, y: -1.0)
                let drawingRect = CGRect(
                    x: 0,
                    y: -cgSourceImage.height,
                    width: cgSourceImage.width,
                    height: cgSourceImage.height
                )
                rendererContext.cgContext.draw(cgSourceImage, in: drawingRect)
                rendererContext.cgContext.restoreGState()

                points.forEach { pair in
                    pair.value.validationStatus.color.toUIColor().setFill()
                    pair.value.validationStatus.color.toUIColor().setStroke()
                    let ellipse = CGRect(
                        x: pair.value.position.x,
                        y: pair.value.position.y,
                        width: Config.elipseSide,
                        height: Config.elipseSide
                    )
                    rendererContext.cgContext.fillEllipse(in: ellipse)
                }
            }
            return dstImage
        } drawPointsOnTransparentImage: { sourceImage, points in
            let cgSourceImage = sourceImage.cgImage!
            let dstImageSize = CGSize(width: cgSourceImage.width, height: cgSourceImage.height)
            let dstImageFormat = UIGraphicsImageRendererFormat()
            dstImageFormat.scale = 1

            let renderer = UIGraphicsImageRenderer(
                size: dstImageSize,
                format: dstImageFormat
            )

            let dstImage = renderer.image { rendererContext in
                points.forEach { pair in
                    pair.value.validationStatus.color.toUIColor().setFill()
                    pair.value.validationStatus.color.toUIColor().setStroke()
                    let ellipse = CGRect(
                        x: pair.value.position.x,
                        y: pair.value.position.y,
                        width: Config.elipseSide,
                        height: Config.elipseSide
                    )
                    rendererContext.cgContext.fillEllipse(in: ellipse)
                }

                rendererContext.cgContext.setLineWidth(5)

                tryToDrawLine(
                    rendererContext.cgContext,
                    points[PoseJoint.Name.neck],
                    points[PoseJoint.Name.root]
                )

                tryToDrawLine(
                    rendererContext.cgContext,
                    points[PoseJoint.Name.rightShoulder],
                    points[PoseJoint.Name.rightElbow]
                )

                tryToDrawLine(
                    rendererContext.cgContext,
                    points[PoseJoint.Name.rightElbow],
                    points[PoseJoint.Name.rightWrist]
                )

                tryToDrawLine(
                    rendererContext.cgContext,
                    points[PoseJoint.Name.leftShoulder],
                    points[PoseJoint.Name.leftElbow]
                )

                tryToDrawLine(
                    rendererContext.cgContext,
                    points[PoseJoint.Name.leftElbow],
                    points[PoseJoint.Name.leftWrist]
                )

                tryToDrawLine(
                    rendererContext.cgContext,
                    points[PoseJoint.Name.root],
                    points[PoseJoint.Name.rightKnee]
                )

                tryToDrawLine(
                    rendererContext.cgContext,
                    points[PoseJoint.Name.rightKnee],
                    points[PoseJoint.Name.rightAnkle]
                )

                tryToDrawLine(
                    rendererContext.cgContext,
                    points[PoseJoint.Name.root],
                    points[PoseJoint.Name.leftKnee]
                )

                tryToDrawLine(
                    rendererContext.cgContext,
                    points[PoseJoint.Name.leftKnee],
                    points[PoseJoint.Name.leftAnkle]
                )

                tryToDrawLine(
                    rendererContext.cgContext,
                    points[PoseJoint.Name.leftHip],
                    points[PoseJoint.Name.rightHip]
                )

                rendererContext.cgContext.drawPath(using: .fillStroke)
            }
            return dstImage
        }

    }
}
