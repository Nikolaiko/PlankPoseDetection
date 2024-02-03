//
//  DrawService.swift
//  PoseDetectionTestToll
//
//  Created by Nikolai Baklanov on 22.10.2023.
//
import Foundation
import PoseDetection
import AppKit

struct CGImagePainter {
    private static let elipseSide: CGFloat = 20

    func drawPointsOnImage(sourceImage: CGImage, points: [PoseJoint.Name: PoseJoint]) -> NSImage {
        let cgSourceImage = sourceImage
        let dstImageSize = CGSize(width: cgSourceImage.width, height: cgSourceImage.height)

        let targetImage = NSImage(size: dstImageSize)
        let bitmapRepresentation = NSBitmapImageRep(
            bitmapDataPlanes: nil,
            pixelsWide: Int(dstImageSize.width),
            pixelsHigh: Int(dstImageSize.height),
            bitsPerSample: 8,
            samplesPerPixel: 4,
            hasAlpha: true,
            isPlanar: false,
            colorSpaceName: .calibratedRGB,
            bytesPerRow: sourceImage.bytesPerRow,
            bitsPerPixel: sourceImage.bitsPerPixel
        )!
        targetImage.addRepresentation(bitmapRepresentation)
        targetImage.lockFocus()

        let ctx = NSGraphicsContext.current!
        let flipVertical = CGAffineTransform(a: 1, b: 0, c: 0, d: -1, tx: 0, ty: dstImageSize.height)
        ctx.cgContext.concatenate(flipVertical)

        ctx.cgContext.setFillColor(CGColor(red: 255, green: 0, blue: 0, alpha: 1))

        points.forEach { pair in
            let ellipse = CGRect(
                x: pair.value.position.x,
                y: pair.value.position.y,
                width: CGImagePainter.elipseSide,
                height: CGImagePainter.elipseSide
            )
            ctx.cgContext.fillEllipse(in: ellipse)
        }

        targetImage.unlockFocus()
        return targetImage
    }

//    func drawPointsOnTransparentImage(sourceImage: UIImage, points: [PoseJoint.Name: PoseJoint]) -> UIImage {
//        let cgSourceImage = sourceImage.cgImage!
//        let dstImageSize = CGSize(width: cgSourceImage.width, height: cgSourceImage.height)
//        let dstImageFormat = UIGraphicsImageRendererFormat()
//        dstImageFormat.scale = 1
//
//        let renderer = UIGraphicsImageRenderer(
//            size: dstImageSize,
//            format: dstImageFormat
//        )
//
//        let dstImage = renderer.image { rendererContext in
//            points.forEach { pair in
//                pair.value.validationStatus.color.toUIColor().setFill()
//                pair.value.validationStatus.color.toUIColor().setStroke()
//                let ellipse = CGRect(
//                    x: pair.value.position.x,
//                    y: pair.value.position.y,
//                    width: CGImagePainter.elipseSide,
//                    height: CGImagePainter.elipseSide
//                )
//                rendererContext.cgContext.fillEllipse(in: ellipse)
//            }
//
//            rendererContext.cgContext.setLineWidth(5)
//
////            tryToDrawLine(
////                context: rendererContext.cgContext,
////                source: points[PoseJoint.Name.leftShoulder],
////                dest: points[PoseJoint.Name.rightShoulder]
////            )
//
//            tryToDrawLine(
//                context: rendererContext.cgContext,
//                source: points[PoseJoint.Name.neck],
//                dest: points[PoseJoint.Name.root]
//            )
//
//            tryToDrawLine(
//                context: rendererContext.cgContext,
//                source: points[PoseJoint.Name.rightShoulder],
//                dest: points[PoseJoint.Name.rightElbow]
//            )
//
//            tryToDrawLine(
//                context: rendererContext.cgContext,
//                source: points[PoseJoint.Name.rightElbow],
//                dest: points[PoseJoint.Name.rightWrist]
//            )
//
//            tryToDrawLine(
//                context: rendererContext.cgContext,
//                source: points[PoseJoint.Name.leftShoulder],
//                dest: points[PoseJoint.Name.leftElbow]
//            )
//
//            tryToDrawLine(
//                context: rendererContext.cgContext,
//                source: points[PoseJoint.Name.leftElbow],
//                dest: points[PoseJoint.Name.leftWrist]
//            )
//
//            tryToDrawLine(
//                context: rendererContext.cgContext,
//                source: points[PoseJoint.Name.root],
//                dest: points[PoseJoint.Name.rightKnee]
//            )
//
//            tryToDrawLine(
//                context: rendererContext.cgContext,
//                source: points[PoseJoint.Name.rightKnee],
//                dest: points[PoseJoint.Name.rightAnkle]
//            )
//
//            tryToDrawLine(
//                context: rendererContext.cgContext,
//                source: points[PoseJoint.Name.root],
//                dest: points[PoseJoint.Name.leftKnee]
//            )
//
//            tryToDrawLine(
//                context: rendererContext.cgContext,
//                source: points[PoseJoint.Name.leftKnee],
//                dest: points[PoseJoint.Name.leftAnkle]
//            )
//
//            tryToDrawLine(
//                context: rendererContext.cgContext,
//                source: points[PoseJoint.Name.leftHip],
//                dest: points[PoseJoint.Name.rightHip]
//            )
//
//            rendererContext.cgContext.drawPath(using: .fillStroke)
//        }
//        return dstImage
//    }
//
//    private func tryToDrawLine(context: CGContext, source: PoseJoint?, dest: PoseJoint?) {
//        if let source = source, let dest = dest {
//            let lineColor = getLineColorForPoints(source: source, dest: dest)
//            context.setStrokeColor(lineColor.cgColor)
//            context.setFillColor(lineColor.cgColor)
//            context.move(to: source.position)
//            context.addLine(to: dest.position)
//            context.strokePath()
//
//        }
//    }
//
//    private func getLineColorForPoints(source: PoseJoint, dest: PoseJoint) -> UIColor {
//        return source.validationStatus == .correct && dest.validationStatus == .correct
//            ? PoseJoint.Validation.correct.color.toUIColor()
//            : PoseJoint.Validation.wrong.color.toUIColor()
//    }
}

