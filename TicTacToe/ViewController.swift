//
//  ViewController.swift
//  TicTacToe
//
//  Created by Jim Campagno on 2/5/17.
//  Copyright © 2017 Jim Campagno. All rights reserved.
//

import UIKit

class ViewController: UIViewController, BoardDelegate {

  @IBOutlet weak var boardZero: Board!
  @IBOutlet weak var boardOne: Board!
  @IBOutlet weak var boardTwo: Board!

  @IBOutlet weak var boardThree: Board!
  @IBOutlet weak var boardFour: Board!
  @IBOutlet weak var boardFive: Board!

  @IBOutlet weak var boardSix: Board!
  @IBOutlet weak var boardSeven: Board!
  @IBOutlet weak var boardEight: Board!
  @IBOutlet weak var winnerLabel: UILabel!



  var totalX  : Int = 0
  var totalO : Int = 0


  let winningConditions = [[0,1,2],
                           [3,4,5],
                           [6,7,8],
                           [0,4,8],
                           [2,4,6],
                           [0,3,6],
                           [1,4,7],
                           [2,5,8]]

  var boardZeroPosition : [Player] = [.y, .y, .y, .y, .y, .y, .y, .y, .y]
  var boardOnePosition : [Player] = [.y, .y, .y, .y, .y, .y, .y, .y, .y]
  var boardTwoPosition : [Player] = [.y, .y, .y, .y, .y, .y, .y, .y, .y]
  var boardThreePosition : [Player] = [.y, .y, .y, .y, .y, .y, .y, .y, .y]
  var boardFourPosition : [Player] = [.y, .y, .y, .y, .y, .y, .y, .y, .y]
  var boardFivePosition : [Player] = [.y, .y, .y, .y, .y, .y, .y, .y, .y]
  var boardSixPosition : [Player] = [.y, .y, .y, .y, .y, .y, .y, .y, .y]
  var boardSevenPosition : [Player] = [.y, .y, .y, .y, .y, .y, .y, .y, .y]
  var boardEightPosition : [Player] = [.y, .y, .y, .y, .y, .y, .y, .y, .y]




  var playerPosition : [Int : [Player]] = [:]

  var ultimateWinner : [Player] = [.y, .y, .y, .y, .y, .y, .y, .y, .y]









  var allBoards: [Board] {
    return [boardZero, boardOne, boardTwo, boardThree, boardFour, boardFive, boardSix, boardSeven, boardEight]
  }


  override func viewDidLoad() {
    super.viewDidLoad()
    initialSetup()
    winnerLabel.text = ""
  }

  func initialSetup() {
    var boardPosition = 0
    for board in allBoards {
      board.position = boardPosition
      board.delegate = self
      boardPosition += 1

    }
  }

  func playerTurn(board: Board, position: Int) -> Player {


    if totalX == totalO {
      totalX += 1
      switch board.position {
      case 0:
        boardZeroPosition[position] = .x
        playerPosition.updateValue(boardZeroPosition, forKey: 0)
      case 1:
        boardOnePosition[position] = .x
        playerPosition.updateValue(boardOnePosition, forKey: 1)
      case 2:
        boardTwoPosition[position] = .x
        playerPosition.updateValue(boardTwoPosition, forKey: 2)
      case 3:
        boardThreePosition[position] = .x
        playerPosition.updateValue(boardThreePosition, forKey: 3)
      case 4:
        boardFourPosition[position] = .x
        playerPosition.updateValue(boardFourPosition, forKey: 4)
      case 5:
        boardFivePosition[position] = .x
        playerPosition.updateValue(boardFivePosition, forKey: 5)
      case 6:
        boardSixPosition[position] = .x
        playerPosition.updateValue(boardSixPosition, forKey: 6)
      case 7:
        boardSevenPosition[position] = .x
        playerPosition.updateValue(boardSevenPosition, forKey: 7)
      case 8:
        boardEightPosition[position] = .x
        playerPosition.updateValue(boardEightPosition, forKey: 8)
      default:
        print("o_O")
      }
      checkSmallBoardWin(board: board)

      return .x
    } else {
      totalO += 1

      switch board.position {
      case 0:
        boardZeroPosition[position] = .o
        playerPosition.updateValue(boardZeroPosition, forKey: 0)
      case 1:
        boardOnePosition[position] = .o
        playerPosition.updateValue(boardOnePosition, forKey: 1)
      case 2:
        boardTwoPosition[position] = .o
        playerPosition.updateValue(boardTwoPosition, forKey: 2)
      case 3:
        boardThreePosition[position] = .o
        playerPosition.updateValue(boardThreePosition, forKey: 3)
      case 4:
        boardFourPosition[position] = .o
        playerPosition.updateValue(boardFourPosition, forKey: 4)
      case 5:
        boardFivePosition[position] = .o
        playerPosition.updateValue(boardFivePosition, forKey: 5)
      case 6:
        boardSixPosition[position] = .o
        playerPosition.updateValue(boardSixPosition, forKey: 6)
      case 7:
        boardSevenPosition[position] = .o
        playerPosition.updateValue(boardSevenPosition, forKey: 7)
      case 8:
        boardEightPosition[position] = .o
        playerPosition.updateValue(boardEightPosition, forKey: 8)
      default:
        print("o_O")
      }

      checkSmallBoardWin(board: board)

      return .o
    }


  }

  func checkSmallBoardWin(board : Board) {
    let smallBoard = playerPosition[board.position]
    var winner : [Player] = []
    for condition in winningConditions {

      for index in condition {
        winner.append(smallBoard![index])
      }

      if winner[0] == winner[1] && winner[0] == winner[2] && winner[2] == winner[1] && winner[0] != .y {
        board.win(for: winner[0])
        ultimateWinner[board.position!] = winner[0]
        totalWinner()
      }

      winner.removeAll()

    }

  }

  func totalWinner(){
    var winner : [Player] = []
    for condition in winningConditions {

      for index in condition {

        winner.append(ultimateWinner[index])

      }

      if winner[0] == winner[1] && winner[0] == winner[2] && winner[2] == winner[1] && winner[0] != .y {

        if winner[0] == .x {
          winnerLabel.text = "X  wins"
        } else {
          winnerLabel.text = "O  wins"
        }
      }
      
      winner.removeAll()
      
    }


  }

  func turnDone() {
//    let randomBoard = arc4random_uniform(8) + 0
//    let board = allBoards[Int(randomBoard)]
//    let randomPosition = arc4random_uniform(8) + 0
//    let imageView = board[Int(randomPosition)]
  }


}
