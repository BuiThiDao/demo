//
//  GradientDetail.swift
//  movie_ios
//
//  Created by user on 25/02/2023.
//

import UIKit

import UIKit

@IBDesignable
class GradientDetailView: UIView {
    
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
        
        let colorLeft =  UIColor(red: 43/255.0, green: 88/255.0, blue: 118/255.0, alpha:0.8).cgColor
        let colorRight = UIColor(red: 78/255.0, green: 67/255.0, blue: 118/255.0, alpha: 0.8).cgColor
        gradient.colors = [colorLeft, colorRight]
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        self.layer.insertSublayer(gradient, at: 0)
        
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(red:255/255, green:255/255, blue:255/255, alpha: 0.2).cgColor
        self.layer.cornerRadius = 50.0
        self.layer.shouldRasterize = false
        self.layer.rasterizationScale = 2
        self.clipsToBounds = true
        self.layer.masksToBounds = true
        
        
    }
    
}
