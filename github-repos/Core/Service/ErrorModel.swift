
import UIKit

class ErrorModel
{
    var description: String = "Bir Hata Oluştu"
    
    init(){}
    
    init(response: BaseResponseModel)
    {
        if let message = response.message {
            self.description = message
        }
    }
    
    init(error: Error?)
    {
        if let error = error
        {
            self.description = error.localizedDescription
        }
    }
    
    init(description: String)
    {
        self.description = description
    }
}
