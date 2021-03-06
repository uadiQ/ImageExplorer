//
//  PostTableViewCell.swift
//  ImageExplorer
//
//  Created by Vadim Shoshin on 14.06.2018.
//  Copyright © 2018 Vadim Shoshin. All rights reserved.
//

import UIKit
import SDWebImage
import PKHUD

protocol PostSharing: class {
    func share(urlToShare: URL)
}

protocol FavouriteAdding: class {
    func processAddition(of post: Post)
}

class PostTableViewCell: UITableViewCell {
    static let reuseID = String(describing: PostTableViewCell.self)
    static let nib = UINib(nibName: String(describing: PostTableViewCell.self), bundle: nil)
    
    @IBOutlet private weak var likeButton: UIButton!
    @IBOutlet private weak var cardView: UIView!
    @IBOutlet private weak var photoImage: UIImageView!
    
    private var post: Post!
    weak var delegate: PostSharing?
    weak var favouriteAddingDelegate: FavouriteAdding?
    
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
    
    func update(with post: Post) {
        self.post = post
        if let image = post.fullPhotoImage {
            photoImage.image = image
        } else {
            guard let imageUrl = URL(string: post.urls.regular) else { return }
            photoImage.sd_setImage(with: imageUrl)
        }
        likeButton.isEnabled = !isFavourite(post: post)
    }
    
    func isFavourite(post: Post) -> Bool {
        for item in DataManager.instance.favourites {
            if item == post {
                return true
            }
        }
        return false
    }
    
    @IBAction func shareButtonPushed(_ sender: UIButton) {
        guard let urlToShare = URL(string: post.links.html) else { return }
        delegate?.share(urlToShare: urlToShare)
    }
    
    @IBAction func likeButtonPushed(_ sender: UIButton) {
        favouriteAddingDelegate?.processAddition(of: post)
//        HUD.flash(.labeledSuccess(title: "Meal added to Favorites!", subtitle: nil), delay: 0.5)
//        DataManager.instance.addToFavourites(post: post)
        likeButton.isEnabled = !isFavourite(post: post)
    }
}
