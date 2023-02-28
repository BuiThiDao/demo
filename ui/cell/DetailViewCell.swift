//
//  DetailViewCellCollectionViewCell.swift
//  movie_ios
//
//  Created by user on 25/02/2023.
//

import UIKit

class DetailViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleMovie: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var titeCast: UILabel!
    
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var viewImdb: UIView!
    @IBOutlet weak var viewCast: UIView!
    
    @IBOutlet weak var contentMovie: UILabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    
}

