import Foundation

public class AttackTypeFactory {
    
    public static func make(using playerLuck: Int) -> AttackTypeProtocol {
        
        let missLimitRange = Miss.percentage
        let normalLimitRange = Normal.percentage + missLimitRange
        let criticalLimitRange = Critical.percentage + normalLimitRange + playerLuck
        
        let generatedNumber: Int = .random(in: 0...criticalLimitRange)
        
        switch generatedNumber {
        case 0..<missLimitRange:
            Logger.shared.log(message: Messages.miss)
            return Miss()
        case missLimitRange..<normalLimitRange:
            return Normal()
        case normalLimitRange..<criticalLimitRange:
            Logger.shared.log(message: Messages.critical)
            return Critical()
        default:
            return Normal()
        }
        
    }
    
}
