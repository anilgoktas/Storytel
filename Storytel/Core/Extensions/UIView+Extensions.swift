//
//  UIView+Extensions.swift
//  Storytel
//
//  Created by Anil Goktas on 7/19/21.
//

import UIKit

extension UIView {
    
    /// Calculates minimum height for fitting the screen width and returns the size.
    func systemLayoutSizeFittingToScreenWidthAndCompressedHeight() -> CGSize {
        let size = CGSize(width: UIScreen.main.bounds.size.width, height: UIView.layoutFittingCompressedSize.height)
        return systemLayoutSizeFitting(
            size,
            withHorizontalFittingPriority: .defaultHigh,
            verticalFittingPriority: .fittingSizeLevel
        )
    }
    
}
