//
//  APIManager.swift
//  Engineer_AI_Practical
//
//  Created by PCQ166 on 20/12/19.
//  Copyright © 2019 PCQ166. All rights reserved.
//

import Foundation
import Alamofire

class APIManager {
    private let header = ["Content-Type" : "application/json"]
    static let shared = APIManager()
    private let sessionManager : SessionManager!
    
    init() {
        let configuration = URLSessionConfiguration.default
        configuration.httpMaximumConnectionsPerHost = 10
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 60
        self.sessionManager = SessionManager(configuration: configuration)
    }
    
    func fetchData(router: Router, onSuccess success : @escaping (_ response : BaseResponse) -> Void, onfailure failure : @escaping (_ error : WebError) -> Void) {
        let path = router.path.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        var parameter = router.parameters
        
        if router.parameters == nil {
            parameter = [:]
        }
        
        var encoding : ParameterEncoding = JSONEncoding.default
        if router.httpMethod == .get {
            encoding = URLEncoding.default
        }
        
        let request = sessionManager.request(path!, method: router.httpMethod!, parameters: parameter, encoding: encoding, headers: header)
        request.responseJSON { (response) in
            switch response.result {
            case .success:
                if let response = response.result.value as? [String:Any] {
                    let resp = BaseResponse(parameter: response)
                    success(resp)
                }
                else {
                    let error = WebError.parseFail
                    failure(error)
                }
            case .failure(let error):
                if error._code == NSURLErrorTimedOut {
                    failure(.timeout)
                }
                else if error._code == NSURLErrorCannotConnectToHost {
                    failure(.hostFail)
                }
                else if error._code == NSURLErrorCancelled {
                    failure(.cancel)
                }
                else if error._code == NSURLErrorNetworkConnectionLost {
                    failure(.unknown)
                }
                else if error._code == NSURLErrorNotConnectedToInternet {
                    failure(.noInternet)
                }
                else if error._code == NSURLErrorUserCancelledAuthentication {
                    failure(.unAuthorised)
                }
                else {
                    failure(.unknown)
                }
            }
        }
    }
}
