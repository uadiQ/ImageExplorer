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
    let small: String
    let thumb: String
    
//    init?(from json: [String: Any]) {
//        guard let full = json["full"], let regular = json["regular"], let small = json["small"], let thumb = json["small"]
//    }
}

struct User: Codable {
    let name: String
    let username: String
}

struct Links: Codable {
    let html: String
    let download: String
}

struct Post: Codable {
    let id: String
    let urls: Urls
    let links: Links
    let user: User
    
//    init?(from json: JSON) {
//        guard let id = json["id"].string else { print ("error @ getting id"); return nil }
//        guard let user = json["user"].dictionaryObject, let userName = user["name"] else { print ("error @ getting username"); return nil }
//    }
    
}


