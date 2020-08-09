
import UIKit
import Alamofire

class BaseService: NSObject {

    static var baseUrl : String {
        get {
            return "https://api.github.com"
        }
    }

    static func get(url:URLConvertible, parameters:Parameters?, encoding:ParameterEncoding = URLEncoding.default, headers:HTTPHeaders? = nil, success:@escaping (_ responseData:Data?) -> Void, failure:@escaping (_ err:ErrorModel?) -> Void) -> Void{
        
        
        AF.request(url, method: .get, parameters: parameters, encoding: encoding, headers: headers).responseData { (response) in
            switch response.result {
            case .success:
                if response.response?.statusCode == 401 {
                    failure(ErrorModel.init(description: "Unauthorized"))
                }
                else {
                    let responseData : Data? = response.data
                    success(responseData)
                }
            case let .failure(error):
                failure(ErrorModel(error: error))
            }
            
            }.responseJSON { (responseJSON) in
                print("\(url) : \(responseJSON)")
        }
    }
    
    static func post(url:URLConvertible, parameters:Parameters? = nil, encoding:ParameterEncoding = JSONEncoding.default, headers:HTTPHeaders? = nil, success:@escaping (_ responseData:Data?) -> Void, failure:@escaping (_ err:ErrorModel?) -> Void) -> Void  {

        AF.request(url, method: .post, parameters: parameters, encoding: encoding, headers: headers).responseData { (response) in
            switch response.result {
            case .success:
                if response.response?.statusCode == 401 {
                    failure(ErrorModel.init(description: "Unauthorized"))
                }
                else {
                    let responseData : Data? = response.data
                    success(responseData)
                }
            case let .failure(error):
                failure(ErrorModel(error: error))
            }
            
            }.responseJSON { (responseJSON) in
                print("\(url) : \(responseJSON)")
        }
    }

}
