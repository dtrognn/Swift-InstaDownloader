//
//  UIView+Style.swift
//  InstaDownloader
//
//  Created by Vu Duc Trong on 16/04/2023.
//

import UIKit

extension UIView {
    func roundCorners(with radius: CGFloat = 20) {
        layer.cornerRadius = radius
        layer.masksToBounds = false
    }

    func border(width: CGFloat = 1, color: UIColor = .gray) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }

    func addShadow() {
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowRadius = 2
    }

    func applyGradient(colors: [UIColor]) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
