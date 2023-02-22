import Foundation

public class Logger {
    
    public static let shared = Logger.init()
    
    private init() { }
    
    public func log(message: String) {
        print(message)
    }
    
}
