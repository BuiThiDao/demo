//
//  GradientBackground.swift
//  movie_ios
//
//  Created by user on 24/02/2023.
//

import UIKit
@IBDesignable
class GradientView: UIView {
    
    var gradient = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradientView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGradientView()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        gradient.frame = self.bounds
    }
    
    func setupGradientView(){
        //rgba(43, 88, 118, 1)
        let colorLeft =  UIColor(red: 43/255.0, green: 88/255.0, blue: 118/255.0, alpha: 1.0).cgColor
        let colorRight = UIColor(red: 78/255.0, green: 67/255.0, blue: 118/255.0, alpha: 1.0).cgColor
        gradient.colors = [colorLeft, colorRight]
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        self.layer.insertSublayer(gradient, at: 0)
        
    }
    
}
