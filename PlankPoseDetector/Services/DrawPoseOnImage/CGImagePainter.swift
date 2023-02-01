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

    func drawPointsOnImage(sourceImage: UIImage, points: [PoseJoint]) -> UIImage {
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

            points.forEach { point in
                UIColor.red.setFill()
                UIColor.red.setStroke()
                let ellipse = CGRect(
                    x: point.position.x,
                    y: point.position.y,
                    width: CGImagePainter.elipseSide,
                    height: CGImagePainter.elipseSide
                )
                rendererContext.cgContext.fillEllipse(in: ellipse)
            }
        }
        return dstImage
    }

    func drawPointsOnTransparentImage(sourceImage: UIImage, points: [PoseJoint]) -> UIImage {
        let cgSourceImage = sourceImage.cgImage!
        let dstImageSize = CGSize(width: cgSourceImage.width, height: cgSourceImage.height)
        let dstImageFormat = UIGraphicsImageRendererFormat()
        dstImageFormat.scale = 1

        let renderer = UIGraphicsImageRenderer(
            size: dstImageSize,
            format: dstImageFormat
        )

        let dstImage = renderer.image { rendererContext in
            points.forEach { point in
                UIColor.red.setFill()
                UIColor.red.setStroke()
                let ellipse = CGRect(
                    x: point.position.x,
                    y: point.position.y,
                    width: CGImagePainter.elipseSide,
                    height: CGImagePainter.elipseSide
                )
                rendererContext.cgContext.fillEllipse(in: ellipse)
            }
        }
        return dstImage
    }
}
