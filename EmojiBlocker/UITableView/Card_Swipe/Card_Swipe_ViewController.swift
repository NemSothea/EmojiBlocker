//
//  Card_Swipe_ViewController.swift
//  EmojiBlocker
//
//  Created by Bizplay on 2022/09/01.
//

import UIKit

class Card_Swipe_ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var MyCollectionView: UICollectionView!
    @IBOutlet weak var IndicatorView: UIView!
    private let noOfCards = 3
    private let cellID = "card-cell"
    
    private var currentSelectedIndex = 0 {
        didSet {
          updatedSelectedCardIndicator()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.MyCollectionView.delegate = self
        self.MyCollectionView.dataSource = self
        self.MyCollectionView.collectionViewLayout = CardCollectionFlowLayout()
        self.showIndicatorView()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return noOfCards
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        
        if currentSelectedIndex == indexPath.row {
            cell.transformTolarge()
        }
        
        return cell
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        let currentCell = MyCollectionView.cellForItem(at: IndexPath(row: Int(currentSelectedIndex), section: 0))
        currentCell?.transformTolarge()
    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        guard scrollView == MyCollectionView else { return }
        targetContentOffset.pointee = scrollView.contentOffset
        let flowLayout = MyCollectionView.collectionViewLayout as! CardCollectionFlowLayout
        let cellWidthIncludingSpasing = flowLayout.itemSize.width + flowLayout.minimumLineSpacing
        /// When reading from the `pointee` property, the instance referenced by this
        /// pointer must already be initialized. When `pointee` is used as the left
        /// side of an assignment, the instance must be initialized or this
        /// pointer's `Pointee` type must be a trivial type.
        let offset = targetContentOffset.pointee
        let horizontalVelocity = velocity.x
        var selectedIndex = currentSelectedIndex
        
        switch horizontalVelocity {
            //On Swiping
        case _ where horizontalVelocity > 0 :
            selectedIndex = currentSelectedIndex + 1
        case _ where horizontalVelocity < 0 :
            selectedIndex = currentSelectedIndex - 1
        //On dragging
        case _ where horizontalVelocity == 0 :
            // default UIEdgeInsetsZero. add additional scroll area around content
            let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpasing
            let roundedIndex = round(index)
            selectedIndex = Int(roundedIndex)
        default :
            print("Incorrect velocity for collectionView")
        }
        let safeIndex = max(0, min(selectedIndex, noOfCards - 1))
        let selectedIndexPath = IndexPath(row: safeIndex, section: 0)
        flowLayout.collectionView!.scrollToItem(at: selectedIndexPath, at: .centeredHorizontally, animated: true)
        
        let previouseSelectedIndex = IndexPath(row: Int(currentSelectedIndex), section: 0)
        let previousSelectedCell = MyCollectionView.cellForItem(at: previouseSelectedIndex)
        
        let nextSelectedCell = MyCollectionView.cellForItem(at: selectedIndexPath)
        currentSelectedIndex = selectedIndexPath.row
        
        previousSelectedCell?.transformToStandard()
        nextSelectedCell?.transformTolarge()
        
    }
    func showIndicatorView() {
        
    }
    
    
    
    func updatedSelectedCardIndicator() {
        for index in 0...noOfCards - 1 {
            let selectedIndicator : UIImageView? = IndicatorView.viewWithTag(index + 1) as? UIImageView
                selectedIndicator?.tintColor = index == currentSelectedIndex ? UIColor.darkGray : UIColor.lightGray
            
        }
    }
    
}

class CardCollectionFlowLayout : UICollectionViewFlowLayout {
    
    private let itemHeight = 150
    private let itemWidth = 225
    
    override func prepare() {
        
        guard let collectionView = collectionView else { return }
        scrollDirection = .horizontal
        itemSize = CGSize(width: itemWidth, height: itemHeight)

        let peekingItemWidth = itemSize.width / 10
        let horizontalInsets = (collectionView.frame.size.width - itemSize.width) / 2
        collectionView.contentInset = UIEdgeInsets(top: 0, left: horizontalInsets, bottom: 0, right: horizontalInsets)
        minimumLineSpacing = horizontalInsets - peekingItemWidth
        
    }
    
    
}
extension UICollectionViewCell {
    func transformTolarge() {
        UIView.animate(withDuration: 0.2) {
            self.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }
    }
    func transformToStandard() {
        UIView.animate(withDuration: 0.2) {
            self.transform = CGAffineTransform.identity
        }
    }
}
