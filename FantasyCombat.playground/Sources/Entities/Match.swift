import Foundation

public class Match {
    
    public private(set) var lastRound: Round?
    
    private enum AttackType: Int, CaseIterable {
        case miss
        case normal
        case critical
        
        var percentage: Int {
            switch self {
            case .normal: return 60
            default: return 20
            }
        }
        
        var constant: Int {
            switch self {
            case .miss: return 0
            case .critical: return 3
            default: return 1
            }
        }
        
        static func getMaxPercentage(using playerLuck: Int) -> Int {
            var max: Int = 0
            AttackType.allCases.forEach {
                var percentage: Int = $0.percentage
                if $0 == .critical {
                    percentage += playerLuck
                }
                if percentage > max {
                    max = percentage
                }
            }
            return max
        }
        
        static func getType(using playerLuck: Int) -> AttackType {
            
            let maxPercentage: Int = self.getMaxPercentage(using: playerLuck)
            
            let generatedNumber: Int = .random(in: 0...maxPercentage)
            
            let criticalAttackTotalPercentage: Int = AttackType.critical.percentage + playerLuck
            
            if AttackType.miss.percentage == criticalAttackTotalPercentage && generatedNumber <= criticalAttackTotalPercentage {
                return [.miss, .critical].randomElement()!
            }
            
            if AttackType.normal.percentage == criticalAttackTotalPercentage && generatedNumber <= criticalAttackTotalPercentage {
                return [.normal, .critical].randomElement()!
            }
            
            if generatedNumber <= AttackType.miss.percentage {
                return .miss
            }
            
            if generatedNumber <= AttackType.normal.percentage && criticalAttackTotalPercentage > AttackType.normal.percentage {
                return .normal
            }
            
            if generatedNumber <= criticalAttackTotalPercentage {
                return .critical
            }
            
            return .normal
            
        }
        
    }
    
    public init(round: Round) {
        self.lastRound = round
    }
    
    public func addRound(round: Round) {
        let currentRound = lastRound
        lastRound = round
        lastRound?.setPreviousRound(round: currentRound)
    }
    
}
