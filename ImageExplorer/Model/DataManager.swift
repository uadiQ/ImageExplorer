//
//  DataManager.swift
//  ImageExplorer
//
//  Created by Vadim Shoshin on 14.06.2018.
//  Copyright © 2018 Vadim Shoshin. All rights reserved.
//

import Foundation

final class DataManager {
    static let instance = DataManager()
    private let networkManager = NetworkManager.instance
    
    private init() { }
    
    var favourites: [Post] = [] {
        didSet {
            NotificationCenter.default.post(name: .FavouritesChanged, object: nil)
        }
    }
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
            case .success(let data):
                print("received jsonArray")
                do {
                    let decoder = JSONDecoder()
                    let recentsPosts = try decoder.decode([Post].self, from: data)
                    self?.recents = recentsPosts
                } catch let error {
                    print("Failed at parsing posts- " + error.localizedDescription)
                }
                
            case .fail(let error):
                print(error)
            }
        }
    }
    
    func addToFavourites(post: Post) {
        favourites.append(post)
        CoreDataManager.instance.addPostToFavorites(post)
    }
    
    func deleteFromFavourites(post: Post) {
        guard let deletingIndex = favourites.index(of: post) else {print("No such meal at favourites"); return }
        favourites.remove(at: deletingIndex)
        CoreDataManager.instance.deletePostFromFavorites(post)
    }
}
