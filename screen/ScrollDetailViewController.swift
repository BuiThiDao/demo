//
//  ScrollDetailViewController.swift
//  movie_ios
//
//  Created by user on 27/02/2023.
//

import UIKit

class ScrollDetailViewController: UIViewController {
    
    @IBOutlet weak var titlePage: UILabel!
    @IBOutlet weak var titleMovie: UILabel!
    @IBOutlet weak var contentMovie: UILabel!
    @IBOutlet weak var castCollectionView: UICollectionView!
    
    ///Logic
    let fullView: CGFloat = 100
    var partialView: CGFloat {
        return UIScreen.main.bounds.height / 2
    }
    
    ///API
    var movieId : Int = 0
    var listCast: [Cast] = []
    var overviewMovie : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(ScrollableBottomSheetViewController.panGesture))
        gesture.delegate = self
        view.addGestureRecognizer(gesture)
        
        getMovieDetail(movieId: movieId){ movie in
            DispatchQueue.main.async{ [weak self] in
                self?.sumbitData(movieDetail: movie)
            }
        }
        getMovieCredits(movieId: movieId){ [weak self] movieCredits in
            self?.listCast = movieCredits.cast
            DispatchQueue.main.async{ [weak self] in
                self?.castCollectionView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareBackgroundView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.6, animations: { [weak self] in
            let frame = self?.view.frame
            let yComponent = self?.partialView
            self?.view.frame = CGRect(x: 0, y: yComponent!, width: frame!.width, height: frame!.height - 100)
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func panGesture(_ recognizer: UIPanGestureRecognizer) {
        
        let translation = recognizer.translation(in: self.view)
        let velocity = recognizer.velocity(in: self.view)
        
        let y = self.view.frame.minY
        if (y + translation.y >= fullView) && (y + translation.y <= partialView) {
            self.view.frame = CGRect(x: 0, y: y + translation.y, width: view.frame.width, height: view.frame.height)
            recognizer.setTranslation(CGPoint.zero, in: self.view)
        }
        
        if recognizer.state == .ended {
            var duration =  velocity.y < 0 ? Double((y - fullView) / -velocity.y) : Double((partialView - y) / velocity.y )
            
            duration = duration > 1.3 ? 1 : duration
            
            print("duration -- \(duration)")
        }
    }
    
    
    func prepareBackgroundView(){
        let blurEffect = UIBlurEffect.init(style: .dark)
        let visualEffect = UIVisualEffectView.init(effect: blurEffect)
        let bluredView = UIVisualEffectView.init(effect: blurEffect)
        bluredView.contentView.addSubview(visualEffect)
        visualEffect.frame = UIScreen.main.bounds
        bluredView.frame = UIScreen.main.bounds
        view.insertSubview(bluredView, at: 0)
    }
    
    func sumbitData(movieDetail: MovieDetail) {
        self.titlePage.text = movieDetail.title
        self.titlePage.font = UIFont.boldSystemFont(ofSize: 64)
        self.titleMovie.text = movieDetail.title
        self.titleMovie.font = UIFont.boldSystemFont(ofSize: 18)
        self.titleMovie.textAlignment = .center
        self.titlePage.textAlignment = .center
        self.contentMovie.numberOfLines = 0
        self.contentMovie.text = movieDetail.overview
        self.overviewMovie = movieDetail.overview ?? ""
        let readmoreFont = UIFont.boldSystemFont(ofSize: 12)
        let readmoreFontColor = UIColor.init(rgb: 0xFA1F3FE)
        DispatchQueue.main.async {
            self.contentMovie.addTrailing(with: "... ", moreText: "More", moreTextFont: readmoreFont, moreTextColor: readmoreFontColor)
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.showMore(_:)))
        self.contentMovie.isUserInteractionEnabled = true
        self.contentMovie.addGestureRecognizer(tap)
        
        ///
        castCollectionView.delegate = self
        castCollectionView.dataSource = self
        if let flowLayout = castCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.estimatedItemSize = .zero
            castCollectionView.showsHorizontalScrollIndicator = false
        }
    }
    
    @objc func showMore(_ sender: UITapGestureRecognizer? = nil) {
        guard let text = self.contentMovie.text else { return }
        
        let readMore: String = "... More"
        let readLess: String = "Less"
        print("contentMovie -- \(self.contentMovie.text ?? "")")
        
        if (self.contentMovie.text ?? "").contains(readMore) {
            /// ?????c h???t
            self.contentMovie.text = overviewMovie + "Less"
        
        }
        else if (self.contentMovie.text ?? "").contains(readLess) {
            /// ???n b???t
            self.contentMovie.text = overviewMovie
            let readmoreFont = UIFont.boldSystemFont(ofSize: 12)
            let readmoreFontColor = UIColor.init(rgb: 0xFA1F3FE)
            DispatchQueue.main.async {
                self.contentMovie.addTrailing(with: "... ", moreText: "More", moreTextFont: readmoreFont, moreTextColor: readmoreFontColor)
            }
        }
        
    }
}


extension ScrollDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.listCast.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CastCollectionViewCell", for: indexPath) as! CastCollectionViewCell
        cell.imageCast.imageFromURL(urlString: Configs.Network.baseImageUrl + (listCast[indexPath.row].profilePath ?? ""))
        cell.imageCast.layer.borderColor = UIColor(red:255/255, green:255/255, blue:255/255, alpha: 0.2).cgColor
        cell.imageCast.layer.borderWidth = 1.0
        cell.imageCast.layer.cornerRadius = 15
        cell.titleMovie.text = listCast[indexPath.row].originalName
        cell.titleMovie.textAlignment = .center
        cell.titleMovie.numberOfLines = 2
        cell .titleCast.text = listCast[indexPath.row].character ?? ""
        cell.titleCast.textAlignment = .center
        cell.titleCast.numberOfLines = 2
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
}


extension ScrollDetailViewController: UIGestureRecognizerDelegate {
    
    // Solution
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        let gesture = (gestureRecognizer as! UIPanGestureRecognizer)
        let direction = gesture.velocity(in: view).y
        
        let y = view.frame.minY
        if (y == fullView && castCollectionView.contentOffset.y == 0 && direction > 0) || (y == partialView) {
            castCollectionView.isScrollEnabled = false
        } else {
            castCollectionView.isScrollEnabled = true
        }
        
        return false
    }
    
}
