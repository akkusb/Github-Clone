
import UIKit

protocol BaseResponseModel
{
    var isSuccess : Bool {get}
    var message : String? {get}
}

extension BaseResponseModel where Self: Decodable {
    static func decode(_ fromData: Data) throws -> Self {
        let decoder : JSONDecoder = JSONDecoder()
        let response : Self = try decoder.decode(Self.self, from: fromData)
        return response
    }
}
