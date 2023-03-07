import Foundation

do {
    
    let player1: Player = try Player(name: "Midoriya", attack: 10, defence: 3, speed: 50, life: 35, luck: 50)
    let player2: Player = try Player(name: "Bakugo", attack: 10, defence: 5, speed: 40, life: 50, luck: 0)
        
    let match: Match = .init(player1: player1, player2: player2)
    
    match.start()
    
} catch {
    print(error.localizedDescription)
}
