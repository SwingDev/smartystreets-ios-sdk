import XCTest
@testable import SmartyStreets

class MockCrashingSender: SmartySender {
    
    var sendCount:Int
    
    override init() {
        self.sendCount = 0
    }
    
    override func sendRequest(request: SmartyRequest, error: inout NSError!) -> SmartyResponse! {
        self.sendCount += 1
        
        if request.getUrl().contains("RetryThreeTimes") {
            if self.sendCount <= 3 {
                let details = [NSLocalizedDescriptionKey: "You need to retry"]
                error = NSError(domain: "NSCocoaErrorDomain", code: 400, userInfo: details)
                return nil
            }
        } else if request.getUrl().contains("RetryMaxTimes") {
            let details = [NSLocalizedDescriptionKey: "Retrying won't help"]
            error = NSError(domain: "NSCocoaErrorDomain", code: 400, userInfo: details)
            return nil
        } else if request.getUrl().contains("RetryFifteenTimes") {
            if self.sendCount <= 14{
                let details = [NSLocalizedDescriptionKey: "You need to retry"]
                error = NSError(domain: "NSCocoaErrorDomain", code: 400, userInfo: details)
                return nil
            }
        } else if request.getUrl().contains("TooManyRequests") {
            if self.sendCount <= 1{
                return SmartyResponse(statusCode: 429, payload: Data())
            }
        }
        
        return SmartyResponse(statusCode: 200, payload: Data())
    }
}
