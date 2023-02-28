//
//  CastViewCell.swift
//  movie_ios
//
//  Created by user on 25/02/2023.
//

import UIKit
@IBDesignable
class CastViewCell: UIView {
    let iconCategory: UIImageView = {
        let iconCategory = UIImageView()
        iconCategory.translatesAutoresizingMaskIntoConstraints = false
        iconCategory.contentMode = .scaleToFill
        return iconCategory
    } ()
    
    let titleMove: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textAlignment = .center
        title.textColor = .white
        title.font = UIFont.boldSystemFont(ofSize: 8)
        title.numberOfLines = 0
        return title
        
    }()
    
    let title: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textAlignment = .center
        title.textColor = .white
        title.font = UIFont.systemFont(ofSize: 8)
        title.numberOfLines = 0
        return title
        
    }()
    @IBInspectable
    var image: UIImage = UIImage(systemName: "person")! {
        didSet{
            self.iconCategory.image = image
        }
    }
    @IBInspectable
    var desc: String = "" {
        didSet{
            self.title.text = desc
        }
    }
    
    @IBInspectable
    var descMovie: String = "" {
        didSet{
            self.titleMove.text = descMovie
        }
    }
    
    var onPress: ((String) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setupView(){
        self.backgroundColor = .clear
        
        self.addSubview(iconCategory)
        self.addSubview(titleMove)
        self.addSubview(title)
        
        // AUTO LAYOUT
        
        iconCategory.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        iconCategory.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        iconCategory.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        iconCategory.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.65).isActive = true
        
        titleMove.centerXAnchor.constraint(equalTo: iconCategory.centerXAnchor).isActive = true
        titleMove.topAnchor.constraint(equalTo: iconCategory.bottomAnchor, constant: 0).isActive = true
        titleMove.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        
        title.centerXAnchor.constraint(equalTo: titleMove.centerXAnchor).isActive = true
        title.topAnchor.constraint(equalTo: titleMove.bottomAnchor, constant: 3).isActive = true
        title.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapImage))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc func tapImage() {
        onPress?(desc)
    }
}
