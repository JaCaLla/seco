//
//  APIManager.swift
//  seco
//
//  Created by Javier Calatrava on 24/02/2020.
//  Copyright © 2020 Javier Calatrava. All rights reserved.
//

import Foundation
import Alamofire

protocol APIManagerProtocol {

    func getAllRoutes(onSucceed: @escaping (([RouteAPI]) -> Void),
                      onFailed: @escaping ((ResponseCodeAPI) -> Void))

    func getAllRoutes2(onComplete: @escaping (Swift.Result<([RouteAPI]), Error>) -> Void)
}

class APIManager {
    // MARK: - Router

    enum APIRouter: URLRequestConvertible {

        case routes
        case stop(Int)
        
        static let host = "europe-west1-metropolis-fe-test.cloudfunctions.net"
        static let scheme = "https"
        static let baseURLString = scheme + "://" + host

        var method: Alamofire.HTTPMethod {
            switch self {
            case .routes: return .get
            case .stop: return .get
            }
        }


        var path: String {
            switch self {
            case .routes: return "api/trips"
            case .stop (let identifier): return "api/stops/\(identifier)"
            }
        }


        func resolveURLRequest() -> URLRequest {

            guard let url = URL(string: APIRouter.baseURLString) else {
                return URLRequest(url: URL(fileURLWithPath: ""))
            }

            var urlRequest = URLRequest(url: url.appendingPathComponent(path))
            urlRequest.httpMethod = method.rawValue

            switch self {
            case .routes, .stop: return urlRequest
            }
        }

        fileprivate func buildURLRequestForForecast(city: String) -> URLRequest {
            var urlComponents = URLComponents()
            urlComponents.scheme = APIRouter.scheme
            urlComponents.host = APIRouter.host
            urlComponents.path = path

            var urlRequest = URLRequest(url: urlComponents.url ?? URL(fileURLWithPath: ""))

            urlRequest.httpMethod = method.rawValue
            return urlRequest
        }

        // MARK: - URLRequestConvertible
        func asURLRequest() throws -> URLRequest {

            var urlRequest = resolveURLRequest()

            switch self {
            case .routes, .stop:
                urlRequest = resolveURLRequest()
                return try Alamofire.JSONEncoding.default.encode(urlRequest, with: nil)
            }
        }
    }

}

// MARK: - APIManagerProtocol
extension APIManager: APIManagerProtocol {
    func getAllRoutes2(onComplete: @escaping (Swift.Result<([RouteAPI]), Error>) -> Void) {
        Alamofire.request(APIRouter.routes).validate(statusCode: 200..<401).responseJSON { response in
            switch response.result {
            case .success:
                if let resultValue = response.result.value as? [[String: AnyObject]] {
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: resultValue, options: [])
                        let rateAPIArr = try JSONDecoder().decode([RouteAPI].self, from: jsonData)
                        onComplete(.success(rateAPIArr))
                    } catch {
                        let error = NSError(domain: "Domain",
                                            code: ResponseCodeAPI.badFormedJSONModel.rawValue,
                                            userInfo: [:])
                        onComplete(.failure(error))
                    }
                } else {
                    let error = NSError(domain: "Domain",
                                        code: ResponseCodeAPI.missingResponseResultValue.rawValue,
                                        userInfo: [:])
                    onComplete(.failure(error))
                }
            case .failure (let error):
                onComplete(.failure(error))
            }
        }
    }

    func getAllRoutes(onSucceed: @escaping (([RouteAPI]) -> Void),
                      onFailed: @escaping ((ResponseCodeAPI) -> Void)) {

        Alamofire.request(APIRouter.routes).validate(statusCode: 200..<401).responseJSON { response in
            switch response.result {
            case .success:
                if let resultValue = response.result.value as? [[String: AnyObject]] {
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: resultValue, options: [])
                        let rateAPIArr = try JSONDecoder().decode([RouteAPI].self, from: jsonData)
                        onSucceed(rateAPIArr)
                    } catch {
                        onFailed(ResponseCodeAPI.badFormedJSONModel)
                    }
                } else {
                    onFailed(ResponseCodeAPI.missingResponseResultValue)
                }
            case .failure:
                onFailed(ResponseCodeAPI.connectivityError)
            }
        }
    }


}
