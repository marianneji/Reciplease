//
//  SearchSession.swift
//  Reciplease
//
//  Created by Graphic Influence on 16/03/2020.
//  Copyright © 2020 marianne massé. All rights reserved.
//

import Foundation
import Alamofire

protocol AlamoSession {
    func request(with url: URL, callBack: @escaping (DataResponse<Any>) -> Void)
}

final class SearchSession: AlamoSession {
    func request(with url: URL, callBack: @escaping (DataResponse<Any>) -> Void) {
        Alamofire.request(url).responseJSON { responseData in
            callBack(responseData)
        }
    }
}
