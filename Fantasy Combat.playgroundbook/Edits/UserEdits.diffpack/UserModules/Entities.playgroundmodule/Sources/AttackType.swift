import Foundation

protocol AttackTypeProtocol {
    var attackMultiplier: Int { get }
    static var percentage: Int { get }
}

class Miss: AttackTypeProtocol {
    var attackMultiplier: Int = 0
    static var percentage: Int = 20
}

class Normal: AttackTypeProtocol {
    var attackMultiplier: Int = 1
    static var percentage: Int = 60
}

class Critical: AttackTypeProtocol {
    var attackMultiplier: Int = 3
    static var percentage: Int = 20
}
