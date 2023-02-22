import Foundation

public enum Messages {
    public static let gameStarted = "Game started"
    public static let gameEnded = "Game ended"
    public static let miss = "Miss!"
    public static let critical = "Critical!"
    
    public static func playerInfo(playerNumber: Int, name: String, attack: Int, defence: Int, speed: Int, life: Int, luck: Int) -> String {
        return "Player \(playerNumber): \(name), attack: \(attack), defence: \(defence), speed: \(speed), life: \(life), luck: \(luck)"
    }
    
    public static func playerInfectionDamage(name: String, damagePoints: Int) -> String {
        return "\(name) inflicts \(damagePoints) of damage"
    }
    
    public static func playerLife(name: String, life: Int) -> String {
        return "\(name) has \(life) points of life left"
    }
    
    public static func winnerPlayer(name: String) -> String {
        return "\(name) won."
    }
    
    public static func currentRoundNumber(number: UInt) -> String {
        return "Round \(number)"
    }
    
}
