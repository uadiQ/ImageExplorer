//
//  DataManager.swift
//  ImageExplorer
//
//  Created by Vadim Shoshin on 14.06.2018.
//  Copyright © 2018 Vadim Shoshin. All rights reserved.
//

import Foundation
import SDWebImage

final class DataManager {
    static let instance = DataManager()
    private let networkManager = NetworkManager.instance
    
    private init() { self.loadFavourites() }
    
    var favourites: [Post] = []
    
    var recents: [Post] = [] {
        didSet {
            NotificationCenter.default.post(name: .RecentsUpdated, object: nil)
        }
    }
    
    func loadFavourites() {
        if !CoreDataManager.instance.isFavoritesEmpty {
            CoreDataManager.instance.fetchFavorites {[unowned self] fetchedFavorites in
                self.favourites = fetchedFavorites
            }
        }
    }
    
    func fetchRecentPhotos() {
        networkManager.fetchRecentPhotos { [weak self] result in
            switch result {
            case .success(let jsonValue):
                guard let jsonArray = jsonValue.array else {print("Error at transition into array"); return }
                var fetchedPosts: [Post] = []
                for object in jsonArray {
                    guard let post = Post(json: object) else { continue }
                    fetchedPosts.append(post)
                }
                self?.recents = fetchedPosts
                
            case .fail(let error):
                NotificationCenter.default.post(name: .RequestFailed, object: nil)
                print(error)
            }
        }
    }
    
    func addToFavourites(post: Post) {
        var newPost = Post(id: post.id,
                           urls: post.urls,
                           links: post.links,
                           user: post.user)
        
        if let imageUrl = URL(string: newPost.urls.full) {
            newPost.saveMealImage(by: imageUrl)
        }
        favourites.append(newPost)
        CoreDataManager.instance.addPostToFavorites(newPost)
    }
    
    func deleteFromFavourites(post: Post) {
        guard let deletingIndex = favourites.index(of: post) else {print("No such meal at favourites"); return }
        favourites.remove(at: deletingIndex)
        CoreDataManager.instance.deletePostFromFavorites(post)
    }
}
