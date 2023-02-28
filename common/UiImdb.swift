//
//  UiImdb.swift
//  movie_ios
//
//  Created by user on 25/02/2023.
//

import UIKit

class UiImdb: UIView {
    
    var cornerRadiusBoder: Double = 0
    
    @IBInspectable
    var cornerRadius: Double = 0 {
        didSet{
            self.cornerRadiusBoder = cornerRadius
            self.layer.cornerRadius = cornerRadiusBoder
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpView()
    }
    
    func setUpView(){
        self.backgroundColor = UIColor.init(rgb: 0xFFF5C518)
        
    }
    
}
