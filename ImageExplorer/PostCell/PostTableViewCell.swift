//
//  PostTableViewCell.swift
//  ImageExplorer
//
//  Created by Vadim Shoshin on 14.06.2018.
//  Copyright © 2018 Vadim Shoshin. All rights reserved.
//

import UIKit
import SDWebImage

class PostTableViewCell: UITableViewCell {
    static let reuseID = String(describing: PostTableViewCell.self)
    static let nib = UINib(nibName: String(describing: PostTableViewCell.self), bundle: nil)
    
    @IBOutlet private weak var cardView: UIView!
    @IBOutlet weak var photoImage: UIImageView!
    
    enum CardShadow {
        static let color = UIColor.gray.cgColor
        static let opacity: Float = 0.9
        static let offset = CGSize(width: 0, height: 2)
    }
    
    static let height: CGFloat = 350
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupShadow()
        self.selectionStyle = .none
    }
    
    private func setupShadow() {
        cardView.layer.shadowColor = CardShadow.color
        cardView.layer.shadowOffset = CardShadow.offset
        cardView.layer.shadowOpacity = CardShadow.opacity
    }
    
    func update(with imageURL: URL) {
        photoImage.sd_setImage(with: imageURL)
    }
}
