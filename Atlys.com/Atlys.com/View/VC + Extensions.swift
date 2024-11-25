//
//  ScrollView + Extension.swift
//  Atlys.com
//
//  Created by MacBook on 25/11/24.
//

import Foundation
import UIKit

extension ViewController: UIScrollViewDelegate {
    // MARK: - ScrollView Delegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let centerX = scrollView.bounds.width / 2 + scrollView.contentOffset.x
        for imageView in imageViews {
            let viewCenterX = imageView.center.x
            let distance = abs(viewCenterX - centerX)
            
            let maxScale: CGFloat = 1.1
            let minScale: CGFloat = 0.85
            
            // Scale proportionally based on the distance from the center
            let scale = max(maxScale - (distance / scrollView.bounds.width * 0.6), minScale)
            imageView.transform = CGAffineTransform(scaleX: scale, y: scale)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        alignToNearestCenter()
        updatePageControl()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            alignToNearestCenter()
            updatePageControl()
        }
    }
    
    // MARK: - Helpers
    private func alignToNearestCenter() {
        let targetIndex = round(scrollView.contentOffset.x / bannerWidth)
        let clampedIndex = max(0, min(Int(targetIndex), imageViews.count - 1))
        
        let targetOffsetX = CGFloat(clampedIndex) * bannerWidth - scrollView.contentInset.left
        scrollView.setContentOffset(CGPoint(x: targetOffsetX, y: 0), animated: true)
    }
    
    private func updatePageControl() {
        let pageIndex = round(scrollView.contentOffset.x / bannerWidth)
        pageControl.currentPage = Int(pageIndex)
    }
}
