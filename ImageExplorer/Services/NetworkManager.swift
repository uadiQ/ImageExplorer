//
//  NetworkManager.swift
//  ImageExplorer
//
//  Created by Vadim Shoshin on 14.06.2018.
//  Copyright © 2018 Vadim Shoshin. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

enum NetworkError: Error {
    case urlCreation
    case authorization
    case noData
}


final class NetworkManager {
    static let instance = NetworkManager()
    
    private init() { }
    
    func fetchRecentPhotos(completionHandler: @escaping (Result<Data>) -> Void) {
        Alamofire.request(Constants.Networking.photos, headers: Constants.Networking.headers).responseData { (response) in
            switch response.result {
            case .success(let value):
                print("Successfull request")
                completionHandler(.success(value))
                
            case .failure(let error):
                print("failedRequest")
                completionHandler(.fail(error))
                
            }
        }
     
    }
}
