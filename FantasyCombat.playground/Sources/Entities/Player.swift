import Foundation

public struct Player {
    
    private let id: UUID = .init()
    private let name: String
    public private(set) var attack: Int
    public private(set) var defence: Int
    public private(set) var speed: Int
    public private(set) var life: Int
    public private(set) var luck: Int
    
    public init(name:String, attack: Int, defence: Int,  speed: Int, life: Int, luck: Int) throws {
        
        if name.isEmpty {
            throw GameError.playerNameIsMissing
        }
        
        let minValue: Int = 1
        let maxValue: Int = 100
        
        if  attack < minValue   || attack > maxValue ||
            defence < minValue  || defence > maxValue ||
            speed < minValue    || speed > maxValue ||
            life < minValue     || life > maxValue ||
            luck < 0            || luck > maxValue {
            throw GameError.playerEntriesAreWrong
        }
        
        self.name = name
        self.attack = attack
        self.defence = defence
        self.speed = speed
        self.life = life
        self.luck = luck
        
    }
    
    public func getName() -> String {
        return name
    }
    
    public mutating func setLife(_ life: Int) {
        self.life = life
    }
    
}
