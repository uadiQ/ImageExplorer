//
//  Post.swift
//  ImageExplorer
//
//  Created by Vadim Shoshin on 14.06.2018.
//  Copyright © 2018 Vadim Shoshin. All rights reserved.
//

import UIKit
import SwiftyJSON

struct Urls: Codable {
    let full: String
    let regular: String
}

struct User: Codable {
    let name: String
    let username: String
}

struct Links: Codable {
    let html: String
}

struct Post: Codable {
    let id: String
    let urls: Urls
    let links: Links
    let user: User
    
    //let regularPhotoImage: UIImage? = nil
}

extension Post: Equatable {
    static func == (lhs: Post, rhs: Post) -> Bool {
        return lhs.id == rhs.id
    }
}

