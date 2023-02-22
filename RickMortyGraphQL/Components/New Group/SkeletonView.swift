//
//  SkeletonView.swift
//  RickMortyGraphQL
//
//  Created by Hakan on 27.01.2023.
//

import Foundation
import UIKit


/// Black Skeleton View to being in loading views
///  - How To Use: Just add to any view and when loading completed remove it. It handles beyond else.
///  - let skeletonView = SkeletonView()
///  - view.addSubview(skeletonView)
///  - view.removeFromSubviews(skeletonView)
class SkeletonView: UIView {
    
    private var gradientLayer: CAGradientLayer!
    
    private var gradientColorOne : CGColor = UIColor(white: 0.25, alpha: 1.0).cgColor
    private var gradientColorTwo : CGColor = UIColor(white: 0.35, alpha: 1.0).cgColor
    
    // we've used frame init cause we produced it in a way programmatic, init(coder:) -> nib
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isHidden = true
    }
    
    // this init will produce an runtime error when try to
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        if let _ = self.superview {
            self.isHidden = false
            self.fillSuperView()
            self.startAnimating()
        } else {
            self.stopAnimating()
            self.isHidden = true
            self.removeFromSuperview()
        }
    }
    
    private func startAnimating() {
        
        gradientLayer = CAGradientLayer()
        gradientLayer.cornerRadius = 18
        
        // using superview bounds to get non zero value
        gradientLayer.frame = superview?.bounds ?? .zero
        
        
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.colors = [gradientColorOne, gradientColorTwo,   gradientColorOne]
        gradientLayer.locations = [0.0, 0.5, 1.0]
        // Adding the gradient layer on to the superview
        superview?.layer.addSublayer(gradientLayer)
        
        
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [-1.0, -0.5, 0.0]
        animation.toValue = [1.0, 1.5, 2.0]
        animation.repeatCount = .infinity
        animation.duration = 1.2
        
        gradientLayer.add(animation, forKey: animation.keyPath)
    }
    
    private func stopAnimating() {
        self.gradientLayer.removeFromSuperlayer()
        self.removeFromSuperview()
    }
}
