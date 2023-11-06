//
//  RestService.swift
//  Pods
//
//  Created by Ogan Topkaya on 31/03/16.
//
//

import Foundation
import Alamofire
import ObjectMapper
import PromiseKit

public protocol RestService {
    
    func url() -> URL
    
    func HTTPHeaders() -> [String: String]
    
    func parameters() -> [String:Any]?
    
    func method()-> HTTPMethod
    
    func parameterEncoding() -> ParameterEncoding
    
    func performRequest<T: Sequence>(_ mapTo: T.Type) -> Promise<[T.Iterator.Element]> where T.Iterator.Element : Mappable
    
    func performRequest<T: Mappable>(_ mapTo: T.Type) -> Promise<T>
    
    func performRequest() -> Promise<String>
    
    func performRequestData() -> Promise<Data>
    
    func errorTranslator(dataResponse: DataResponse<String>) -> Error?
    
    func log(_ string: String)
    
    var sessionManager: Alamofire.SessionManager {get}
}

public enum RestServiceError: Error{
    case unknownError
}

public extension RestService {
    
    func performRequest() -> Promise<String>{
        return Promise { seal in
            self.sessionManager
                .request(url(),
                         method: self.method(),
                         parameters: self.parameters(),
                         encoding: self.parameterEncoding(),
                         headers: self.HTTPHeaders())
                .validate()
                .responseString { (response: DataResponse<String>) in
                    
                    if let url = response.request?.url {
                        self.log(">> \(self.method().rawValue.uppercased()) \(url)")
                        if let body = response.request?.httpBody, let str = String(data: body, encoding: .utf8) {
                            self.log(">> \(str)")
                        }
                    }
                    
                    if let responseData = response.data, let responseStr = String(data: responseData, encoding: String.Encoding.utf8){
                        self.log("<< \(responseStr)")
                    }
                    
                    if let error = self.errorTranslator(dataResponse: response){
                        seal.reject(error)
                    }
                    else {
                        switch response.result{
                        case .success(let value):
                            seal.fulfill(value)
                        case .failure(let error):
                            seal.reject(error)
                        }
                    }
            }
        }
    }
    
    func performRequestData() -> Promise<Data> {
        return Promise { seal in
        self.sessionManager
            .request(url(),
                     method: self.method(),
                     parameters: self.parameters(),
                     encoding: self.parameterEncoding(),
                     headers: self.HTTPHeaders())
            .validate()            
            .responseString { (response: DataResponse<String>) in
                
                if let url = response.request?.url {
                    self.log(">> \(self.method().rawValue.uppercased()) \(url)")
                    if let body = response.request?.httpBody, let str = String(data: body, encoding: .utf8) {
                        self.log(">> \(str)")
                    }
                }
                
                if let error = self.errorTranslator(dataResponse: response){
                    seal.reject(error)
                }
                else if let responseData = response.data{
                    seal.fulfill(responseData)
                }
            }
        }
    }
    
    func performRequest<T: Mappable>(_ mapTo: T.Type) -> Promise<T>{
        return self.performRequest().then { response -> Promise<T> in
            if let result = T(JSONString: response){
                return .value(result)
            }
            throw RestServiceError.unknownError
        }
        
    }
    
    func performRequest<T: Sequence>(_ mapTo: T.Type) -> Promise<[T.Iterator.Element]> where T.Iterator.Element : Mappable{
        return self.performRequest().then { response -> Promise<[T.Iterator.Element]> in
            if let result = Mapper<T.Iterator.Element>().mapArray(JSONString: response){
                return .value(result)
            }
            throw RestServiceError.unknownError
        }
    }
    
    func log(_ string: String){
        print(string)
    }
    
    var sessionManager: Alamofire.SessionManager {
        return SessionManager.default
    }
    
}
