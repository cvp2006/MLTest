//
//  UICollectionViewFlowLayoutCenterItem.swift
//  MLTest
//
//  Created by Carlos Velasquez on 11/05/23.
//

import UIKit

class UICollectionViewFlowLayoutCenterItem: UICollectionViewFlowLayout {
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        self.scrollDirection = .horizontal
        if let cv = self.collectionView {

            cv.isPagingEnabled = true
            let cvBounds = cv.bounds
            let halfWidth = cvBounds.size.width * 0.5;
            let proposedContentOffsetCenterX = proposedContentOffset.x + halfWidth;

            if let attributesForVisibleCells = self.layoutAttributesForElements(in: cvBounds) {

                var candidateAttributes : UICollectionViewLayoutAttributes?
                for attributes in attributesForVisibleCells {

                    if attributes.representedElementCategory != UICollectionView.ElementCategory.cell {
                        continue
                    }
                    if let candAttrs = candidateAttributes {
                        let a = attributes.center.x - proposedContentOffsetCenterX
                        let b = candAttrs.center.x - proposedContentOffsetCenterX
                        if fabsf(Float(a)) < fabsf(Float(b)) {
                            candidateAttributes = attributes;
                        }
                        
                    } else {
                        candidateAttributes = attributes;
                        continue;
                    }
                }
                
                return CGPoint(x: round(candidateAttributes!.center.x - halfWidth), y: proposedContentOffset.y)
            }
        }
        
        return super.targetContentOffset(forProposedContentOffset: proposedContentOffset)
    }
}
