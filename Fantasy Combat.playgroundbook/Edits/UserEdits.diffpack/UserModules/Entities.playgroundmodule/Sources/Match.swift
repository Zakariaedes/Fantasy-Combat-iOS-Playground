import Foundation
import Tools
import Enums

public class Match {
    
    private static let maxAttacksPerRound: Int = 2
    
    public private(set) var player1: Player
    public private(set) var player2: Player
    public var roundNumber: UInt = 1
    
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
                max += $0.percentage
            }
            return max + playerLuck
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
    
    public init(player1: Player, player2: Player) {
        self.player1 = player1
        self.player2 = player2
    }
    
    private func getAttackerAndDefender() -> (attacker: Player, defender: Player) {
        if player1.speed == player2.speed {
            let randomPlayer: Player = [player1, player2].randomElement()!
            if randomPlayer == player1 {
                return (player1, player2)
            }
            return (player2, player1)
        }
        if player1.speed > player2.speed {
            return (player1, player2)
        }
        return (player2, player1)
    }
    
    private func swap(attacker: inout Player, with defender: inout Player) {
        let tempAttacker: Player = attacker
        attacker = defender
        defender = tempAttacker
    }
    
    private func logStartGameMessages(player1: Player, player2: Player) {
        Logger.shared.log(message: Messages.gameStarted.uppercased())
        Logger.shared.log(message: Messages.playerInfo(playerNumber: 1, name: player1.name, attack: player1.attack, defence: player1.defence, speed: player1.speed, life: player1.life, luck: player1.luck))
        Logger.shared.log(message: Messages.playerInfo(playerNumber: 2, name: player2.name, attack: player2.attack, defence: player2.defence, speed: player2.speed, life: player2.life, luck: player2.luck))
        Logger.shared.log(message: Messages.currentRoundNumber(number: roundNumber))
    }
    
    private func logEndGameMessages() {
        let winnerName: String = !player1.isAlive() ? player2.name : player1.name
        Logger.shared.log(message: Messages.winnerPlayer(name: winnerName))
        Logger.shared.log(message: Messages.gameEnded.uppercased())
    }
    
    private func logAndUpdateRoundNumber(using attacksPerRound: inout Int) {
        if attacksPerRound == Match.maxAttacksPerRound {
            roundNumber += 1
            attacksPerRound = 0
            Logger.shared.log(message: Messages.currentRoundNumber(number: roundNumber))
        }
    }
    
    private func logAttackTypeAndCalculateDamage(attacker: Player, defender: Player, attackType: AttackType, byUpdating damagePoints: inout Int) {
        
        if attackType == .miss {
            Logger.shared.log(message: Messages.miss)
        } else {
            
            if attackType == .critical {
                Logger.shared.log(message: Messages.critical)
            }
            
            damagePoints = defender.calculateDamagePoints(attacker: attacker, multipliedBy: attackType.constant)
            
        }
        
        Logger.shared.log(message: Messages.playerInfectionDamage(name: attacker.name, damagePoints: damagePoints))
        Logger.shared.log(message: Messages.playerLife(name: defender.name, life: defender.life))
        
    }
    
}

extension Match {
    
    public func play() {
        
        var (attacker, defender) = getAttackerAndDefender()
        var attacksPerRound: Int = 0
        
        logStartGameMessages(player1: attacker, player2: defender)
        
        repeat {
            
            let attackType: AttackType = AttackType.getType(using: attacker.luck)
            var damagePoints: Int = 0
            
            logAndUpdateRoundNumber(using: &attacksPerRound)
            
            logAttackTypeAndCalculateDamage(attacker: attacker, defender: defender, attackType: attackType, byUpdating: &damagePoints)
            
            swap(attacker: &attacker, with: &defender)
            
            attacksPerRound += 1
            
        } while (attacker.isAlive() && defender.isAlive())
        
        logEndGameMessages()
        
        
    }
    
}