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
        // resize recipe header
        self.brandDashboardControllerDelegate?.minimizeBrandsCollectionView(scrollPositionY: scrollView.contentOffset.y)


        // fade out splash image logic
        if scrollView.contentOffset.y > 0 {
            fadePctSplashImg = 1 - (scrollView.contentOffset.y / 100)
        }

        // fade out only if fade alpha is within range
        if fadePctSplashImg ?? CGFloat(0) >= CGFloat(0) && fadePctSplashImg ?? CGFloat(1) <= CGFloat(1) {
            parentViewControllerDelegate?.fadeOutSplashImg(fadePct: fadePctSplashImg ?? 0.0)
        }
        

        // set fadeOut status based on last direction user scrolled
        if scrollView.panGestureRecognizer.translation(in: scrollView).y > 0 {
            if fadeOut != false {
                fadeOut = false
                self.parentViewControllerDelegate?.setFadeOut(fadeOut: false)
            }
            
        } else if scrollView.panGestureRecognizer.translation(in: scrollView).y < -0 {
            if fadeOut != true {
                fadeOut = true
                self.parentViewControllerDelegate?.setFadeOut(fadeOut: true)
            }
        }


        // fadeOut based on last direction that user is scrolling past a threshhold
        if scrollView.panGestureRecognizer.translation(in: scrollView).y > 75 {
            if fadeOut != false {
                fadeOut = false
                self.parentViewControllerDelegate?.setFadeOut(fadeOut: false)
                self.parentViewControllerDelegate?.fadeTabBar(fadePct: 1.0)
            }

        } else if scrollView.panGestureRecognizer.translation(in: scrollView).y < -75 {
            if fadeOut != true {
                fadeOut = true
                self.parentViewControllerDelegate?.setFadeOut(fadeOut: true)
                self.parentViewControllerDelegate?.fadeTabBar(fadePct: 0.0)
            }

        } else {
            // do nothing
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
            print("default fade")
            
            // fade out splash image logic
            if scrollView.contentOffset.y > 0 {
                fadePctSplashImg = 1 - (scrollView.contentOffset.y / 100)
            }
            
            fadeOut = false
            self.parentViewControllerDelegate?.setFadeOut(fadeOut: false)
            self.parentViewControllerDelegate?.fadeTabBar(fadePct: 1.0)
        }
    }
    
}
