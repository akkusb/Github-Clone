//
//  BaseView.swift
//  FYMMobil
//
//  Created by Burhan on 31.01.2020.
//  Copyright © 2020 Horizon. All rights reserved.
//

import UIKit

@IBDesignable
class BaseView: UIView {
    
    override func awakeFromNib() {
        self.layer.masksToBounds = cornerRadius > 0
        self.initialize()
    }

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.masksToBounds = cornerRadius > 0
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            self.layer.borderWidth = newValue
        }
        get {
            return self.layer.borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        set {
            self.layer.borderColor = newValue?.cgColor
        }
        get {
            if let color = self.layer.borderColor {
                return UIColor.init(cgColor: color)
            }
            return nil
        }
    }
    
    func initialize() {
        
    }
//
//    @IBInspectable var isTopLeftRounded: Bool = true
//    @IBInspectable var isTopRightRounded: Bool = true
//    @IBInspectable var isBottomLeftRounded: Bool = true
//    @IBInspectable var isBottomRightRounded: Bool = true
//
//    private var cornerRadiusLayer: CAShapeLayer?
//
//    var fillColor: UIColor? {
//        return self.backgroundColor
//    }
//
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//        if cornerRadiusLayer?.frame != self.layer.frame {
//
//
//            var roundingCorners: UIRectCorner = UIRectCorner.init()
//            if isTopLeftRounded {
//                roundingCorners.insert(.topLeft)
//            }
//            if isTopRightRounded {
//                roundingCorners.insert(.topRight)
//            }
//            if isBottomLeftRounded {
//                roundingCorners.insert(.bottomLeft)
//            }
//            if isBottomRightRounded {
//                roundingCorners.insert(.bottomRight)
//            }
//
//            if roundingCorners != [.topLeft, .topRight, .bottomLeft, .bottomRight] {
//                cornerRadiusLayer = CAShapeLayer()
//                cornerRadiusLayer?.path = UIBezierPath(roundedRect: bounds, byRoundingCorners: roundingCorners, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)).cgPath
//
//                cornerRadiusLayer?.fillColor = fillColor?.cgColor
//
//                layer.insertSublayer(cornerRadiusLayer!, at: 0)
//                self.cornerRadiusLayer?.masksToBounds = cornerRadius > 0
//                self.backgroundColor = .clear
//            }
//        }
//
//    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
