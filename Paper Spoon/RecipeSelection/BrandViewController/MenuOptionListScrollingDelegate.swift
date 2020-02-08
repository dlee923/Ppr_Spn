//
//  MenuOptionListScrollingDelegate.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 1/25/20.
//  Copyright © 2020 DLEE. All rights reserved.
//

import UIKit

extension MenuOptionList {
    
    // MARK:  Scrolling delegate method.
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // only activate if position is beyond max scroll
        if scrollView.contentOffset.y < 100 {
            // resize recipe header
            self.brandDashboardControllerDelegate?.minimizeBrandsCollectionView(scrollPositionY: scrollView.contentOffset.y)

            
        }
        
        if scrollView.contentOffset.y < 150 {
            // fade out splash image logic
            fadePctSplashImg = 1 - (scrollView.contentOffset.y / 100)
            parentViewControllerDelegate?.fadeOutSplashImg(fadePct: fadePctSplashImg ?? 0.0)
        }

        // set fadeOut status based on last direction user scrolled
        if scrollView.panGestureRecognizer.translation(in: scrollView).y > 0 {
            if fadeOut != false {
                fadeOut = false
                self.parentViewControllerDelegate?.setFadeOut(fadeOut: false)
                self.parentViewControllerDelegate?.fadeTabBar(fadePct: 1.0)
            }
            
        } else if scrollView.panGestureRecognizer.translation(in: scrollView).y < -0 {
            if fadeOut != true {
                fadeOut = true
                self.parentViewControllerDelegate?.setFadeOut(fadeOut: true)
                self.parentViewControllerDelegate?.fadeTabBar(fadePct: 0.0)
            }
        }

    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if fadeOut == true {
            // animate alpha 0
            self.parentViewControllerDelegate?.fadeTabBar(fadePct: 0.0)
        } else if fadeOut == false {
            // animate alpha 1
            self.parentViewControllerDelegate?.fadeTabBar(fadePct: 1.0)
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if fadeOut == true {
            // animate alpha 0
            self.parentViewControllerDelegate?.fadeTabBar(fadePct: 0.0)
        } else if fadeOut == false {
            // animate alpha 1
            self.parentViewControllerDelegate?.fadeTabBar(fadePct: 1.0)
        }

        if scrollView.contentOffset.y <= (-self.contentInsetValue - 44 + 10) {
            fadeOut = false
            self.parentViewControllerDelegate?.setFadeOut(fadeOut: false)
            self.parentViewControllerDelegate?.fadeTabBar(fadePct: 1.0)
        } else {
            
        }
    }
    
}
