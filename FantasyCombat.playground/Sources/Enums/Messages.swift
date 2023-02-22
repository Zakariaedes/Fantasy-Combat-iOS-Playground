import Foundation

public enum Messages {
    static let gameStarted = "Game started"
    static let gameEnded = "Game ended"
    static let miss = "Miss!"
    static let critical = "Critical!"
    
    static func playerInfo(playerNumber: Int, player: Player) -> String {
        return "Player \(playerNumber): \(player.name), attack: \(player.attack), defence: \(player.defence), speed: \(player.speed), life: \(player.life), luck: \(player.luck)"
    }
    
    static func playerInfectionDamage(name: String, damagePoints: Int) -> String {
        return "\(name) inflicts \(damagePoints) of damage"
    }
    
    static func playerLife(of player: Player) -> String {
        return "\(player.name) has \(player.life) points of life left"
    }
    
    static func winnerPlayer(name: String) -> String {
        return "\(name) won."
    }
    
    static func currentRoundNumber(number: UInt) -> String {
        return "Round \(number)"
    }
    
}
