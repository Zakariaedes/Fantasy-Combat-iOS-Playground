import Foundation


var player1: Player = try! Player(name: "Midoriya", attack: 10, defence: 3, speed: 50, life: 35, luck: 50)
var player2: Player = try! Player(name: "Bakugo", attack: 10, defence: 5, speed: 40, life: 50, luck: 0)
let round: Round = try! .init(number: 1, player1: player1, player2: player2)
let match: Match = .init(round: round)

try? match.play()
