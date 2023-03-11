//
//  CGImagePainter.swift
//  PlankPoseDetector
//
//  Created by Nikolai Baklanov on 29.01.2023.
//

import Foundation
import UIKit

struct CGImagePainter: DrawImageService {
    private static let elipseSide: CGFloat = 10

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
                UIColor.red.setFill()
                UIColor.red.setStroke()
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
                UIColor.red.setFill()
                UIColor.red.setStroke()
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
                source: points[PoseJoint.Name.leftShoulder]?.position,
                dest: points[PoseJoint.Name.rightShoulder]?.position
            )

            tryToDrawLine(
                context: rendererContext.cgContext,
                source: points[PoseJoint.Name.neck]?.position,
                dest: points[PoseJoint.Name.root]?.position
            )

            tryToDrawLine(
                context: rendererContext.cgContext,
                source: points[PoseJoint.Name.rightShoulder]?.position,
                dest: points[PoseJoint.Name.rightElbow]?.position
            )

            tryToDrawLine(
                context: rendererContext.cgContext,
                source: points[PoseJoint.Name.rightElbow]?.position,
                dest: points[PoseJoint.Name.rightWrist]?.position
            )

            tryToDrawLine(
                context: rendererContext.cgContext,
                source: points[PoseJoint.Name.leftShoulder]?.position,
                dest: points[PoseJoint.Name.leftElbow]?.position
            )

            tryToDrawLine(
                context: rendererContext.cgContext,
                source: points[PoseJoint.Name.leftElbow]?.position,
                dest: points[PoseJoint.Name.leftWrist]?.position
            )

            tryToDrawLine(
                context: rendererContext.cgContext,
                source: points[PoseJoint.Name.rightHip]?.position,
                dest: points[PoseJoint.Name.rightKnee]?.position
            )

            tryToDrawLine(
                context: rendererContext.cgContext,
                source: points[PoseJoint.Name.rightKnee]?.position,
                dest: points[PoseJoint.Name.rightAnkle]?.position
            )

            tryToDrawLine(
                context: rendererContext.cgContext,
                source: points[PoseJoint.Name.leftHip]?.position,
                dest: points[PoseJoint.Name.leftKnee]?.position
            )

            tryToDrawLine(
                context: rendererContext.cgContext,
                source: points[PoseJoint.Name.leftKnee]?.position,
                dest: points[PoseJoint.Name.leftAnkle]?.position
            )

            tryToDrawLine(
                context: rendererContext.cgContext,
                source: points[PoseJoint.Name.leftHip]?.position,
                dest: points[PoseJoint.Name.rightHip]?.position
            )

            rendererContext.cgContext.drawPath(using: .fillStroke)
        }
        return dstImage
    }

    private func tryToDrawLine(context: CGContext, source: CGPoint?, dest: CGPoint?) {
        if let source = source, let dest = dest {
            context.move(to: source)
            context.addLine(to: dest)
        }
    }
}
