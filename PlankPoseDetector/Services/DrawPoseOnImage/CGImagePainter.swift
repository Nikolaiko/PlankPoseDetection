//
//  CGImagePainter.swift
//  PlankPoseDetector
//
//  Created by Nikolai Baklanov on 29.01.2023.
//

import Foundation
import UIKit

struct CGImagePainter: DrawImageService {
    private static let elipseSide: CGFloat = 20

    func drawPointsOnImage(sourceImage: UIImage, points: [PoseJoint.Name: PoseJoint]) -> UIImage {
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
                pair.value.validationStatus.color.setFill()
                pair.value.validationStatus.color.setStroke()
                let ellipse = CGRect(
                    x: pair.value.position.x,
                    y: pair.value.position.y,
                    width: CGImagePainter.elipseSide,
                    height: CGImagePainter.elipseSide
                )
                rendererContext.cgContext.fillEllipse(in: ellipse)
            }
        }
        return dstImage
    }

    func drawPointsOnTransparentImage(sourceImage: UIImage, points: [PoseJoint.Name: PoseJoint]) -> UIImage {
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
                pair.value.validationStatus.color.setFill()
                pair.value.validationStatus.color.setStroke()
                let ellipse = CGRect(
                    x: pair.value.position.x,
                    y: pair.value.position.y,
                    width: CGImagePainter.elipseSide,
                    height: CGImagePainter.elipseSide
                )
                rendererContext.cgContext.fillEllipse(in: ellipse)
            }

            rendererContext.cgContext.setLineWidth(5)

            tryToDrawLine(
                context: rendererContext.cgContext,
                source: points[PoseJoint.Name.leftShoulder],
                dest: points[PoseJoint.Name.rightShoulder]
            )

            tryToDrawLine(
                context: rendererContext.cgContext,
                source: points[PoseJoint.Name.neck],
                dest: points[PoseJoint.Name.root]
            )

            tryToDrawLine(
                context: rendererContext.cgContext,
                source: points[PoseJoint.Name.rightShoulder],
                dest: points[PoseJoint.Name.rightElbow]
            )

            tryToDrawLine(
                context: rendererContext.cgContext,
                source: points[PoseJoint.Name.rightElbow],
                dest: points[PoseJoint.Name.rightWrist]
            )

            tryToDrawLine(
                context: rendererContext.cgContext,
                source: points[PoseJoint.Name.leftShoulder],
                dest: points[PoseJoint.Name.leftElbow]
            )

            tryToDrawLine(
                context: rendererContext.cgContext,
                source: points[PoseJoint.Name.leftElbow],
                dest: points[PoseJoint.Name.leftWrist]
            )

            tryToDrawLine(
                context: rendererContext.cgContext,
                source: points[PoseJoint.Name.rightHip],
                dest: points[PoseJoint.Name.rightKnee]
            )

            tryToDrawLine(
                context: rendererContext.cgContext,
                source: points[PoseJoint.Name.rightKnee],
                dest: points[PoseJoint.Name.rightAnkle]
            )

            tryToDrawLine(
                context: rendererContext.cgContext,
                source: points[PoseJoint.Name.leftHip],
                dest: points[PoseJoint.Name.leftKnee]
            )

            tryToDrawLine(
                context: rendererContext.cgContext,
                source: points[PoseJoint.Name.leftKnee],
                dest: points[PoseJoint.Name.leftAnkle]
            )

            tryToDrawLine(
                context: rendererContext.cgContext,
                source: points[PoseJoint.Name.leftHip],
                dest: points[PoseJoint.Name.rightHip]
            )

            rendererContext.cgContext.drawPath(using: .fillStroke)
        }
        return dstImage
    }

    private func tryToDrawLine(context: CGContext, source: PoseJoint?, dest: PoseJoint?) {
        if let source = source, let dest = dest {
            let lineColor = getLineColorForPoints(source: source, dest: dest)
            context.setStrokeColor(lineColor.cgColor)
            context.setFillColor(lineColor.cgColor)
            context.move(to: source.position)
            context.addLine(to: dest.position)
            context.strokePath()

        }
    }

    private func getLineColorForPoints(source: PoseJoint, dest: PoseJoint) -> UIColor {
        return source.validationStatus == .correct && dest.validationStatus == .correct
            ? PoseJoint.Validation.correct.color
            : PoseJoint.Validation.wrong.color
    }
}
