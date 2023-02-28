//
//  ViewController.swift
//  movie_ios
//
//  Created by user on 24/02/2023.
//

import UIKit

class ViewController: UIViewController {
    
    ///UI
    // @IBOutlet weak var upCommingPageController: UIPageControl!
    @IBOutlet weak var upCommingPageController: UIView!
    @IBOutlet weak var upCommingConllection: UICollectionView!
    @IBOutlet weak var titleUpComming: UILabel!
    var sizeItemUpComming : Double = 0
    
    /// Data
    var lstMoviePopular: [MovieRecommend] = []
    var lstUpComming: [MovieRecommend] = []
    /// get sizeItem
    var sizeItemMostPopular : Double = 0
    
    @IBOutlet weak var pageController: UIView!
    @IBOutlet weak var mostPopularCollection: UICollectionView!
    
    
    ///Indicator
    private var currentSelectedPoplarIndex = 1 {
        didSet {
            updateSelectedIndicatorPopular()
        }
    }
    
    private var currentSelectedUpCommingIndex = 1 {
        didSet {
            updateSelectedIndicatorUpComming()
        }
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mostPopularCollection.delegate = self
        mostPopularCollection.dataSource = self
        if let flowLayout = mostPopularCollection.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.estimatedItemSize = .zero
            mostPopularCollection.showsHorizontalScrollIndicator = false
        }
        
        upCommingConllection.delegate = self
        upCommingConllection.dataSource = self
        if let flowLayout = upCommingConllection.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.estimatedItemSize = .zero
            upCommingConllection.showsHorizontalScrollIndicator = false
        }
        ///API popular
        getMovieRecommend() { movies in
            self.lstMoviePopular = movies
            DispatchQueue.main.async{ [weak self] in
                self?.mostPopularCollection.reloadData()
                self?.mostPopularCollection.scrollToItem(at: IndexPath(row: 1, section: 0), at: .centeredHorizontally, animated: false)
                self?.showIndicatorView()
            }
        }
        ///API UpComming
        getUpcomingMovies() { movies in
            self.lstUpComming = movies
            DispatchQueue.main.async{ [weak self] in
                self?.upCommingConllection.reloadData()
                self?.upCommingConllection.scrollToItem(at: IndexPath(row: 1, section: 0), at: .centeredHorizontally, animated: false)
                self?.showIndicatorUpCommingView()
            }
        }
    }
    
    
    func showIndicatorView() {
        let stackView = UIStackView()
        stackView.axis  = NSLayoutConstraint.Axis.horizontal
        stackView.distribution  = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing = 8.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        for index in 0..<self.lstMoviePopular.count {
            let dot = UIImageView(image: UIImage(named: "ic_ellipse_fill.png"))
            dot.heightAnchor.constraint(equalToConstant: 10).isActive = true
            dot.widthAnchor.constraint(equalToConstant: 10).isActive = true
            dot.tag = index + 1
            
            if index == currentSelectedPoplarIndex {
                dot.image = UIImage(named: "ic_ellipse.png")
            }
            stackView.addArrangedSubview(dot)
        }
        
        pageController.subviews.forEach({ $0.removeFromSuperview() })
        pageController.addSubview(stackView)
        
        stackView.centerXAnchor.constraint(equalTo: pageController.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: pageController.centerYAnchor).isActive = true
    }
    
    func updateSelectedIndicatorPopular() {
        for index in 0...self.lstMoviePopular.count - 1 {
            let selectedIndicator: UIImageView? = pageController.viewWithTag(index + 1) as? UIImageView
            selectedIndicator?.image = index == currentSelectedPoplarIndex ? UIImage(named: "ic_ellipse.png"): UIImage(named: "ic_ellipse_fill.png")
        }
    }
    
    func showIndicatorUpCommingView() {
        let stackView = UIStackView()
        stackView.axis  = NSLayoutConstraint.Axis.horizontal
        stackView.distribution  = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing = 8.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        for index in 0..<self.lstUpComming.count {
            let dot = UIImageView(image: UIImage(named: "ic_ellipse_fill.png"))
            dot.heightAnchor.constraint(equalToConstant: 10).isActive = true
            dot.widthAnchor.constraint(equalToConstant: 10).isActive = true
            dot.tag = index + 1
            
            if index == currentSelectedUpCommingIndex {
                dot.image = UIImage(named: "ic_ellipse.png")
            }
            stackView.addArrangedSubview(dot)
        }
        
        upCommingPageController.subviews.forEach({ $0.removeFromSuperview() })
        upCommingPageController.addSubview(stackView)
        
        stackView.centerXAnchor.constraint(equalTo: upCommingPageController.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: upCommingPageController.centerYAnchor).isActive = true
    }
    
    func updateSelectedIndicatorUpComming() {
        for index in 0...self.lstUpComming.count - 1 {
            let selectedIndicator: UIImageView? = upCommingPageController.viewWithTag(index + 1) as? UIImageView
            selectedIndicator?.image = index == currentSelectedUpCommingIndex ? UIImage(named: "ic_ellipse.png"): UIImage(named: "ic_ellipse_fill.png")
        }
    }
    
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == mostPopularCollection{
            return lstMoviePopular.count;
        }
        return lstUpComming.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == mostPopularCollection{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularCollectionViewCell", for: indexPath) as! PopularCollectionViewCell
            cell.imageMostPopular.imageFromURL(urlString: Configs.Network.baseImageUrl + (self.lstMoviePopular[indexPath.row].posterPath ?? ""))
            cell.imageMostPopular.layer.cornerRadius = 30
            cell.imageMostPopular.layer.borderColor = UIColor(red:255/255, green:255/255, blue:255/255, alpha: 0.2).cgColor
            cell.imageMostPopular.layer.borderWidth = 1.0
            cell.titleMovie.text = self.lstMoviePopular[indexPath.row].name ?? ""
            cell.dropShadow(offsetX: 4, offsetY: 4, color: UIColor.init(rgb: 0xFF000000), opacity: 0.025, radius: 30, scale: true)
            
            ///Shadow
            if (currentSelectedPoplarIndex + 1) == indexPath.row {
                cell.viewShadow.setGradientBoderRightToLeftView()
                cell.viewShadow.isHidden = false
                cell.transformToSmall()
            }
            if (currentSelectedPoplarIndex - 1) == indexPath.row {
                cell.viewShadow.setGradientBoderLeftToRightView()
                cell.viewShadow.isHidden = false
                cell.transformToSmall()
                
            }
            if currentSelectedPoplarIndex == indexPath.row {
                cell.viewShadow.isHidden = true
            }
            return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UpCommingViewCell", for: indexPath) as! UpCommingViewCell
            cell.imageUpComming.imageFromURL(urlString: Configs.Network.baseImageUrl + (self.lstUpComming[indexPath.row].posterPath ?? ""))
            cell.imageUpComming.layer.cornerRadius = 30
            cell.imageUpComming.layer.borderColor = UIColor(red:255/255, green:255/255, blue:255/255, alpha: 0.2).cgColor
            cell.imageUpComming.layer.borderWidth = 2.0
            cell.dropShadow(offsetX: 4, offsetY: 4, color: UIColor.init(rgb: 0xFF000000), opacity: 0.025, radius: 30, scale: true)
            
            if (currentSelectedUpCommingIndex + 1) == indexPath.row {
                cell.viewShadow.setGradientBoderRightToLeftView()
                cell.viewShadow.isHidden = false
            }
            if (currentSelectedPoplarIndex - 1) == indexPath.row {
                cell.viewShadow.setGradientBoderLeftToRightView()
                cell.viewShadow.isHidden = false
                
            }
            if currentSelectedPoplarIndex == indexPath.row {
                cell.viewShadow.isHidden = true
            }
            return cell
        }
    }
    
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if scrollView == mostPopularCollection{
            let currentCell = mostPopularCollection.cellForItem(at: IndexPath(row: Int(currentSelectedPoplarIndex), section: 0))
            currentCell?.transformToStandard()
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if scrollView == mostPopularCollection{
            guard scrollView == mostPopularCollection else {
                return
            }
            
            targetContentOffset.pointee = scrollView.contentOffset
            let cellWidthIncludingSpacing = self.sizeItemMostPopular + 0
            let offset = targetContentOffset.pointee
            let horizontalVelocity = velocity.x
            
            var selectedIndex = currentSelectedPoplarIndex
            
            switch horizontalVelocity {
                // On swiping
            case _ where horizontalVelocity > 0 :
                selectedIndex = currentSelectedPoplarIndex + 1
            case _ where horizontalVelocity < 0:
                selectedIndex = currentSelectedPoplarIndex - 1
                
                // On dragging
            case _ where horizontalVelocity == 0:
                let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
                let roundedIndex = round(index)
                
                selectedIndex = Int(roundedIndex)
            default:
                print("No")
            }
            
            let safeIndex = max(0, min(selectedIndex, lstMoviePopular.count - 1))
            let selectedIndexPath = IndexPath(row: safeIndex, section: 0)
            let indexCheck = currentSelectedPoplarIndex > safeIndex ? (safeIndex - 1) : (safeIndex + 1)
            mostPopularCollection!.scrollToItem(at: selectedIndexPath, at: .centeredHorizontally, animated: true)
            let isBefore = safeIndex > currentSelectedPoplarIndex
            print("")
            if(currentSelectedPoplarIndex != safeIndex){
                
                let previousSelectedIndex = IndexPath(row: Int(currentSelectedPoplarIndex), section: 0)
                let previousSelectedCell = mostPopularCollection.cellForItem(at: previousSelectedIndex) as! PopularCollectionViewCell
                let currentSelectedCell = mostPopularCollection.cellForItem(at: selectedIndexPath) as! PopularCollectionViewCell
                
                currentSelectedPoplarIndex = selectedIndexPath.row
                currentSelectedCell.viewShadow.isHidden = true
                currentSelectedCell.transformToStandard()
                
                //Shadow
                print("previousSelectedCell -- \(currentSelectedPoplarIndex)")
                previousSelectedCell.viewShadow.clearGradientLayer()
                if isBefore {
                    print(" previous -- setGradientBoderLeftToRightView")
                    previousSelectedCell.viewShadow.setGradientBoderLeftToRightView()
                }
                else{
                    print("previous --setGradientBoderRightToLeftView")
                    previousSelectedCell.viewShadow.setGradientBoderRightToLeftView()
                }
                previousSelectedCell.viewShadow.isHidden = false
                previousSelectedCell.transformToSmall()
                
                if(safeIndex != 0){
                    print("indexCheck -- \(indexCheck)")
                    let selectedIndexOldPath = IndexPath(row: indexCheck, section: 0)
                    let currentOld = self.mostPopularCollection?.cellForItem(at: selectedIndexOldPath)
                    if(currentOld != nil){
                        let popularCollectionViewCell = currentOld as! PopularCollectionViewCell
                        popularCollectionViewCell.viewShadow.clearGradientLayer()
                        if indexCheck < safeIndex {
                            print("setGradientBoderLeftToRightView")
                            popularCollectionViewCell.viewShadow.setGradientBoderLeftToRightView()
                        }
                        else{
                            print("setGradientBoderRightToLeftView")
                            popularCollectionViewCell.viewShadow.setGradientBoderRightToLeftView()
                        }
                        popularCollectionViewCell.viewShadow.isHidden = false
                        popularCollectionViewCell.transformToSmall()
                    }else{
                        print("No action")
                    }
                }
            }
            else{
                ///NoAction
            }
            
        } else{
            guard scrollView == upCommingConllection else {
                return
            }
            
            targetContentOffset.pointee = scrollView.contentOffset
            let cellWidthIncludingSpacing = self.sizeItemUpComming + 0
            let offset = targetContentOffset.pointee
            let horizontalVelocity = velocity.x
            
            var selectedIndex = currentSelectedUpCommingIndex
            
            switch horizontalVelocity {
                // On swiping
            case _ where horizontalVelocity > 0 :
                selectedIndex = currentSelectedUpCommingIndex + 1
            case _ where horizontalVelocity < 0:
                selectedIndex = currentSelectedUpCommingIndex - 1
                
                // On dragging
            case _ where horizontalVelocity == 0:
                let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
                let roundedIndex = round(index)
                
                selectedIndex = Int(roundedIndex)
            default:
                print("No")
            }
            
            
            let safeIndex = max(0, min(selectedIndex, lstUpComming.count - 1))
            let selectedIndexPath = IndexPath(row: safeIndex, section: 0)
            let indexCheck = currentSelectedUpCommingIndex > safeIndex ? (safeIndex - 1) : (safeIndex + 1)
            upCommingConllection!.scrollToItem(at: selectedIndexPath, at: .centeredHorizontally, animated: true)
            let isBefore = safeIndex > currentSelectedUpCommingIndex
            print("")
            if(currentSelectedUpCommingIndex != safeIndex){
                
                let previousSelectedIndex = IndexPath(row: Int(currentSelectedUpCommingIndex), section: 0)
                let previousSelectedCell = upCommingConllection.cellForItem(at: previousSelectedIndex) as! UpCommingViewCell
                let currentSelectedCell = upCommingConllection.cellForItem(at: selectedIndexPath) as! UpCommingViewCell
                
                currentSelectedUpCommingIndex = selectedIndexPath.row
                currentSelectedCell.viewShadow.isHidden = true
                
                //Shadow
                print("previousSelectedCell -- \(currentSelectedUpCommingIndex)")
                previousSelectedCell.viewShadow.clearGradientLayer()
                if isBefore {
                    print(" previous -- setGradientBoderLeftToRightView")
                    previousSelectedCell.viewShadow.setGradientBoderLeftToRightView()
                }
                else{
                    print("previous --setGradientBoderRightToLeftView")
                    previousSelectedCell.viewShadow.setGradientBoderRightToLeftView()
                }
                previousSelectedCell.viewShadow.isHidden = false
                
                if(safeIndex != 0){
                    print("indexCheck -- \(indexCheck)")
                    let selectedIndexOldPath = IndexPath(row: indexCheck, section: 0)
                    let currentOld = self.upCommingConllection?.cellForItem(at: selectedIndexOldPath)
                    if(currentOld != nil){
                        let upCommingViewCell = currentOld as! UpCommingViewCell
                        upCommingViewCell.viewShadow.clearGradientLayer()
                        if indexCheck < safeIndex {
                            print("setGradientBoderLeftToRightView")
                            upCommingViewCell.viewShadow.setGradientBoderLeftToRightView()
                        }
                        else{
                            print("setGradientBoderRightToLeftView")
                            upCommingViewCell.viewShadow.setGradientBoderRightToLeftView()
                        }
                        upCommingViewCell.viewShadow.isHidden = false
                    }else{
                        print("No action")
                    }
                }
            }
            else{
                ///NoAction
            }
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == mostPopularCollection{
            let heightCollection = collectionView.frame.size.height
            let heightItem = heightCollection
            let widthItem = collectionView.frame.size.width * 0.78
            self.sizeItemMostPopular = widthItem
            return CGSize(width: widthItem, height: heightItem)
        }
        else{
            let heightCollection = collectionView.frame.size.height
            let heightItem = heightCollection
            let widthItem = collectionView.frame.size.width * 0.45
            self.sizeItemUpComming = widthItem
            return CGSize(width: widthItem, height: heightItem)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var movie: MovieRecommend
        print(indexPath.row)
        if collectionView == mostPopularCollection {
            movie = self.lstMoviePopular[indexPath.row]
        } else {
            movie = self.lstUpComming[indexPath.row]
        }
        tapMovie(movie: movie)
    }
    func tapMovie(movie: MovieRecommend) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        vc?.urlString = Configs.Network.baseImageUrl + (movie.posterPath ?? "")
        vc?.movieId = movie.id ?? 0
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}




