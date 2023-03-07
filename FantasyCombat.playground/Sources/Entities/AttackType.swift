import Foundation

public protocol AttackTypeProtocol {
    var attackMultiplier: Int { get }
    static var percentage: Int { get }
}

public class Miss: AttackTypeProtocol {
    public var attackMultiplier: Int = 0
    public static var percentage: Int = 20
}

public class Normal: AttackTypeProtocol {
    public var attackMultiplier: Int = 1
    public static var percentage: Int = 60
}

public class Critical: AttackTypeProtocol {
    public var attackMultiplier: Int = 3
    public static var percentage: Int = 20
}
