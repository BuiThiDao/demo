//
//  DetailViewController.swift
//  movie_ios
//
//  Created by user on 24/02/2023.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageBack: UIImageView!
    @IBOutlet weak var imageDetail: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    var urlString : String = ""
    var movieId : Int = 0
    
    func setUpView(){
        imageDetail.setGradientBoderTopToBottomView()
        imageDetail.imageFromURL(urlString: urlString)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageBack.isUserInteractionEnabled = true
        imageBack.addGestureRecognizer(tapGestureRecognizer)
        
        addBottomSheetView()
        
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        print("imageTapped")
        self.navigationController?.popViewController(animated: true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addBottomSheetView(scrollable: Bool? = true) {
        
        let mainStorboard = UIStoryboard(name: "Main", bundle: nil)
        let bottomSheetVC = mainStorboard.instantiateViewController(withIdentifier: "OtherTestViewController") as! OtherTestViewController
        
        bottomSheetVC.movieId = movieId
        
        // 2- Add bottomSheetVC as a child view
        self.addChild(bottomSheetVC)
        self.view.addSubview(bottomSheetVC.view)
        bottomSheetVC.didMove(toParent: self)
        
        let height = view.frame.height
        let width  = view.frame.width
        bottomSheetVC.view.frame = CGRect(x: 0, y: self.view.frame.maxY, width: width, height: height)
    }
    
    
}
