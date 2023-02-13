import Foundation

public class Match {
    
    private static let maxAttacksPerRound: Int = 2
    
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
    
    private func getAttackerAndDefender(round: Round) -> (attacker: Player, defender: Player) {
        if round.player1.speed == round.player2.speed {
            let randomPlayer: Player = [round.player1, round.player2].randomElement()!
            if randomPlayer == round.player1 {
                return (round.player1, round.player2)
            }
            return (round.player2, round.player1)
        }
        if round.player1.speed > round.player2.speed {
            return (round.player1, round.player2)
        }
        return (round.player2, round.player1)
    }
    
}

extension Match {
    
    public func play() throws {
        
        if var currentRound = lastRound {
            
            var (attacker, defender) = getAttackerAndDefender(round: currentRound)
            var attacksPerRound: Int = 0
            
            print("START GAME")
            print("\nPlayer 1:", attacker.playerDescription)
            print("Player 2:", defender.playerDescription)
            print(currentRound.roundNumberDescription)
            
            repeat {
                
                let attackType: AttackType = AttackType.getType(using: attacker.luck)
                var damagePoints: Int = 0
                
                if attacksPerRound == Match.maxAttacksPerRound {
                    do {
                        let round: Round = try .init(number: nil, player1: defender, player2: attacker, previousRound: currentRound)
                        currentRound = round
                        print(currentRound.roundNumberDescription)
                            attacksPerRound = 0
                    } catch {
                        throw error
                    }
                }
                
                if attackType == .miss {
                    print("Miss!")
                } else {
                    
                    if attackType == .critical {
                        print("Critical!")
                    }
                    
                    damagePoints = (attacker.attack * attackType.constant) - defender.defence
                    
                    defender.setLife(defender.life - damagePoints)
                    
                }
                
                print("\(attacker.getName()) inflicts \(damagePoints) of damage")
                print(defender.lifeDescription)
                
                let tempAttacker: Player = attacker
                attacker = defender
                defender = tempAttacker
                
                attacksPerRound += 1
                
            } while (attacker.life > 0 && defender.life > 0)
            
            let winnerName: String = currentRound.player1.life <= 0 ? currentRound.player2.getName() : currentRound.player1.getName()
            
            print("\n\(winnerName) won.")
            print("END GAME")
            
        }
        
    }
    
}
