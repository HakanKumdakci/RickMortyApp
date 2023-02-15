//
//  UIViewExtensions.swift
//  RickMortyGraphQL
//
//  Created by Hakan on 25.01.2023.
//

import Foundation
import UIKit

extension UIView {
    
    func fillSuperView(inset: UIEdgeInsets = .zero) {
        anchor(top: superview?.topAnchor, leading: superview?.leadingAnchor, bot: superview?.bottomAnchor, right: superview?.rightAnchor, topConstant: inset.top, leftConstant: inset.left, botConstant: inset.bottom, rightConstant: inset.right, width: 0, height: 0)
    }
    
    /// Anchor helper func
    ///  - Important: Center anchors uses top and left constants as constant
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bot: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, topConstant: CGFloat, leftConstant: CGFloat, botConstant: CGFloat, rightConstant: CGFloat, width: CGFloat, height: CGFloat, centerX: NSLayoutXAxisAnchor? = nil, centerY: NSLayoutYAxisAnchor? = nil){
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: topConstant).isActive = true
        }
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: leftConstant).isActive = true
        }
        if let bot = bot {
            bottomAnchor.constraint(equalTo: bot, constant: -botConstant).isActive = true
        }
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -rightConstant).isActive = true
        }
        
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
        if let centerX = centerX {
            centerXAnchor.constraint(equalTo: centerX, constant: topConstant).isActive = true
        }
        
        if let centerY = centerY {
            centerYAnchor.constraint(equalTo: centerY, constant: leftConstant).isActive = true
        }
    }
    
}
