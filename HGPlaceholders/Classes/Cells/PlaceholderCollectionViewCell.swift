//
//  PlaceholderCollectionViewCell.swift
//  Pods
//
//  Created by Hamza Ghazouani on 25/07/2017.
//
//

import UIKit

/// The default cell used for collection view placeholders (takes the size of the collection view)
open class PlaceholderCollectionViewCell: UICollectionViewCell {
    
    var onActionButtonTap: (() -> Void)?

    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var subtitleLabel: UILabel?
    @IBOutlet weak var placeholderImageView: UIImageView?
    @IBOutlet weak var actionButton: UIButton?
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView?
    
     var cellView: UIView {
        return self
    }
    
    //  MARK: - User interaction
    
    @IBAction func sendPlaceholderAction(_ sender: Any) {
        onActionButtonTap?()
        print("Placeholder action button tapped")
    }
}

extension PlaceholderCollectionViewCell: Reusable {}
extension PlaceholderCollectionViewCell: NibLoadable {}
extension PlaceholderCollectionViewCell: CellPlaceholding {
    
    ///  Changes the cell style to match placeholder style
    ///
    /// - Parameters:
    ///   - style: the style to apply
    ///   - tintColor: the tint color, is used for some items when the style color is nil
    public func apply(style: PlaceholderStyle, tintColor: UIColor?) {
        cellView.backgroundColor = style.backgroundColor
        
        let buttonBackgroundColor = style.actionBackgroundColor ?? tintColor
        actionButton?.backgroundColor = buttonBackgroundColor
        
        let actionColor = style.actionTitleColor
        actionButton?.setTitleColor(actionColor, for: .normal)
        actionButton?.titleLabel?.font = style.actionTitleFont
        
        activityIndicator?.color = style.activityIndicatorColor
        
        titleLabel?.textColor = style.titleColor
        titleLabel?.font = style.titleFont
        titleLabel?.textAlignment = style.titleTextAlignment
        
        subtitleLabel?.textColor = style.subtitleColor
        subtitleLabel?.font = style.subtitleFont
        subtitleLabel?.textAlignment = style.subtitleTextAlignment
    }
    
    ///  Sets in the cell the placeholder texts, image, ...
    ///
    /// - Parameter data: the data of the cell (texts, images, etc)
    public func apply(data: PlaceholderData?) {
        actionButton?.setTitle(data?.action, for: .normal)
        actionButton?.isHidden = (data?.action == nil)
        
        titleLabel?.text = data?.title
        subtitleLabel?.text = data?.subtitle
        placeholderImageView?.image = data?.image
        
        data?.showsLoading == true ? activityIndicator?.startAnimating() : activityIndicator?.stopAnimating()
    }
    
}
