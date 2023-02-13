import Foundation

public class Round {
    
    private let id: UUID = .init()
    private let number: UInt
    public private(set) var player1: Player
    public private(set) var player2: Player
    public private(set) var previousRound: Round?
    
    public var roundNumberDescription: String {
        return "\nRound \(number)"
    }
    
    public init(number: UInt? = nil, player1: Player, player2: Player, previousRound: Round? = nil) throws {
        if let previousRound = previousRound {
            self.number = previousRound.getRoundNumber() + 1
        } else if number == 0 || number == nil{
            throw GameError.roundNumberIsNotCorrect
        } else {
            self.number = number!
        }
        self.player1 = player1
        self.player2 = player2
        self.previousRound = previousRound
    }
    
    public func getRoundNumber() -> UInt {
        return number
    }
    
    public func setPreviousRound(round: Round?) {
        self.previousRound = round
    }
    
}
