//
//  ViewController.swift
//  GraphicsForMathTests
//
//  Created by Nikolai Baklanov on 08.10.2023.
//

import UIKit
import LineMath

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let radius: CGFloat = 15.0
        let p1 = CGPoint(x: self.view.frame.midX, y: self.view.frame.midY)


        let circleLayer1 = CAShapeLayer()
        circleLayer1.path = UIBezierPath(
            roundedRect: CGRect(x: 0, y: 0, width: 2.0 * radius, height: 2.0 * radius),
            cornerRadius: radius
        ).cgPath
        circleLayer1.position = CGPoint(x: p1.x - radius, y: p1.y - radius)
        circleLayer1.fillColor = UIColor.blue.cgColor
        self.view.layer.addSublayer(circleLayer1)


        let p2 = CGPoint(x: p1.x + self.view.frame.midX / 2, y: p1.y + self.view.frame.midX / 2)
        let circleLayer2 = CAShapeLayer()
        circleLayer2.path = UIBezierPath(
            roundedRect: CGRect(x: 0, y: 0, width: 2.0 * radius, height: 2.0 * radius),
            cornerRadius: radius
        ).cgPath
        circleLayer2.position = CGPoint(x: p2.x - radius, y: p2.y - radius)
        circleLayer2.fillColor = UIColor.blue.cgColor
        self.view.layer.addSublayer(circleLayer2)




        let p3 = CGPoint(x: p1.x - self.view.frame.midX, y: p1.y + self.view.frame.midX / 1.2)
        let circleLayer3 = CAShapeLayer()
        circleLayer3.path = UIBezierPath(
            roundedRect: CGRect(x: 0, y: 0, width: 2.0 * radius, height: 2.0 * radius),
            cornerRadius: radius
        ).cgPath
        circleLayer3.position = CGPoint(x: p3.x - radius, y: p3.y - radius)
        circleLayer3.fillColor = UIColor.blue.cgColor
        self.view.layer.addSublayer(circleLayer3)



        let params = LineMath.calculateLineParameters(point1: p1, point2: p2)
        let p4 = LineMath.findNearestPointFromStartOnLine(line: params, start: p3)
        let circleLayer4 = CAShapeLayer()
        circleLayer4.path = UIBezierPath(
            roundedRect: CGRect(x: 0, y: 0, width: 2.0 * radius, height: 2.0 * radius),
            cornerRadius: radius
        ).cgPath
        circleLayer4.position = CGPoint(x: p4.x - radius, y: p4.y - radius)
        circleLayer4.fillColor = UIColor.red.cgColor
        self.view.layer.addSublayer(circleLayer4)


        
        print(params)
        print(p3)
        print(p4)
    }


}

