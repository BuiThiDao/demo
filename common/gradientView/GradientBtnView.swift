//
//  GradientBtnView.swift
//  movie_ios
//
//  Created by user on 25/02/2023.
//

import UIKit

@IBDesignable
class GradientBtnView: UIView {
    
    var gradient = CAGradientLayer()
    let title: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textAlignment = .center
        title.textColor = .white
        title.font = UIFont.systemFont(ofSize: 12)
        title.numberOfLines = 0
        return title
        
    }()
    
    @IBInspectable
    var desc: String = "" {
        didSet{
            self.title.text = desc
        }
    }
    
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
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.25
        self.layer.shadowOffset = CGSize(width: -1, height: 1)
        self.layer.shadowRadius = 1
        
        self.layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        self.layer.shouldRasterize = false
        
        
        self.layer.cornerRadius = 12.0
        
        self.layer.rasterizationScale = 2
        self.clipsToBounds = true
        self.layer.masksToBounds = true
        
        self.addSubview(title)
        title.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        title.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
    }
    
}
