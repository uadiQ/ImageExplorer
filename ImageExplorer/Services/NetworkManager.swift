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
    
    private init() {}
    
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
            //        Alamofire.request(Constants.Networking.photos, headers: Constants.Networking.headers).responseJSON { response in
            //            switch response.result {
            //            case .success(let value):
            //                print("Successfull request")
            //                let jsonResponse = JSON(value)
            //                guard let mealsJSONArray = jsonResponse["results"].array else {
            //                    print("Response didn't turn into array")
            //                    completionHandler(.fail(NetworkError.noData))
            //                    return
            //                }
            //                completionHandler(.success(mealsJSONArray))
            //
            //            case .failure(let error):
            //                print("failedRequest")
            //                completionHandler(.fail(error))
            //
            //            }
            //        }
        }
     
    }
}
