import Foundation

public class Match {
    
    public private(set) var lastRound: Round?
    
    public init(round: Round) {
        self.lastRound = round
    }
    
    public func addRound(round: Round) {
        let currentRound = lastRound
        lastRound = round
        lastRound?.setPreviousRound(round: currentRound)
    }
    
}
