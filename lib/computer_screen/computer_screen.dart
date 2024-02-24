import 'package:flutter/material.dart';
import 'dart:math';

// ignore: must_be_immutable
class ComputerScreen extends StatefulWidget {
  const ComputerScreen({super.key});

  @override
  State<ComputerScreen> createState() => ComputerScreenState();
}

class ComputerScreenState extends State<ComputerScreen> {
  String player1 = "", player2 = "";

  bool oTurn = true;
  int xWins = 0, oWins = 0;
  int filledBoxes = 0;
  String winner = "";
  String result = "...";

  List<String> moves = ["", "", "", "", "", "", "", "", ""];
  List<String> prevMove = ["", "", "", "", "", "", "", "", ""];
  List<int> winningIndices = [];

  @override
  void initState() {
    super.initState();
    player1 = "You";
    player2 = "Computer";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tic Tac Toe',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.amberAccent,
        elevation: 6,
        shadowColor: const Color.fromARGB(255, 249, 23, 23),
        titleSpacing: 20,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: const Color.fromARGB(255, 178, 242, 255),
        child: Center(
          child: Column(children: [
            const Expanded(
              flex: 0,
              child: Padding(
                padding: EdgeInsets.only(top: 5, bottom: 2),
                child: Text(
                  "Score Board",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      color: Color.fromARGB(255, 2, 2, 151)),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.center,
                width: 360,
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Text(
                            player1,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                color: Color.fromARGB(255, 2, 2, 151)),
                          ),
                        ),
                        Text(
                          oWins.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: Color.fromARGB(255, 2, 2, 151)),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Text(
                            player2,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                color: Color.fromARGB(255, 2, 2, 151)),
                          ),
                        ),
                        Text(
                          xWins.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: Color.fromARGB(255, 2, 2, 151)),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: GridView.builder(
                  itemCount: 9,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (BuildContext cotext, int index) {
                    return GestureDetector(
                      onTap: () {
                        result == "..." && oTurn ? tapped(index) : null;
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: winningIndices.contains(index)
                                ? Colors.pinkAccent
                                : Colors.amberAccent,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              width: 4,
                              color: const Color.fromARGB(255, 86, 64, 255),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              moves[index],
                              style: const TextStyle(fontSize: 80),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                result,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  color: Color.fromARGB(255, 166, 0, 0),
                  overflow: TextOverflow.fade,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20, top: 6),
              child: ElevatedButton(
                onPressed: () {
                  reset();
                },
                style: const ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll<Color>(Colors.purpleAccent),
                  fixedSize: MaterialStatePropertyAll<Size>(Size(150, 40)),
                ),
                child: const Text(
                  "Reset Game",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  void tapped(int index) {
    setState(() {
      filledBoxes++;
      if (oTurn && moves[index] == "") {
        moves[index] = "⭕";
        oTurn = !oTurn;
        checkWinner();
        if (filledBoxes < 9 && result == "...") {
          computerMove();
        }
        checkWinner();
      }
    });
  }

  void computerMove() {
    //Without AI
    filledBoxes++;
    List<int> emptySpots = [];
    for (int i = 0; i < moves.length; i++) {
      if (moves[i] == "") {
        emptySpots.add(i);
      }
    }

    if (emptySpots.isNotEmpty) {
      int randomIndex = Random().nextInt(emptySpots.length);
      int computerMoveIndex = emptySpots[randomIndex];
      moves[computerMoveIndex] = "❌";
      oTurn = !oTurn;
      checkWinner();
    }
  }

  // void computerMove() {
  //   //With AI
  //   int bestScore = -1000;
  //   int bestMove = -1;

  //   for (int i = 0; i < moves.length; i++) {
  //     if (moves[i] == "") {
  //       moves[i] = "❌"; // Assume computer makes a move

  //       int score = minimax(moves, 0, false);

  //       moves[i] = ""; // Undo the move

  //       if (score > bestScore) {
  //         bestScore = score;
  //         bestMove = i;
  //       }
  //     }
  //   }

  //   if (bestMove != -1) {
  //     moves[bestMove] = "❌"; // Make the best move
  //     oTurn = !oTurn; // Switch turns
  //     checkWinner();
  //   }
  // }

  // int minimax(List<String> board, int depth, bool isMaximizing) {
  //   checkWinner();

  //   if (winner == "⭕") {
  //     return -1;
  //   } else if (winner == "❌") {
  //     return 1;
  //   } else if (filledBoxes == 9) {
  //     return 0; // It's a tie
  //   }

  //   if (isMaximizing) {
  //     int bestScore = -1000;

  //     for (int i = 0; i < board.length; i++) {
  //       if (board[i] == "") {
  //         board[i] = "❌"; // Assume computer makes a move
  //         int score = minimax(board, depth + 1, false);
  //         board[i] = ""; // Undo the move
  //         bestScore = max(score, bestScore);
  //       }
  //     }

  //     return bestScore;
  //   } else {
  //     int bestScore = 1000;

  //     for (int i = 0; i < board.length; i++) {
  //       if (board[i] == "") {
  //         board[i] = "⭕"; // Assume player makes a move
  //         int score = minimax(board, depth + 1, true);
  //         board[i] = ""; // Undo the move
  //         bestScore = min(score, bestScore);
  //       }
  //     }

  //     return bestScore;
  //   }
  // }

  void checkWinner() {
    setState(() {
      if (moves[0] == moves[1] && moves[0] == moves[2] && moves[0] != "") {
        winner = moves[0];
        if (winningIndices.isEmpty) {
          winningIndices.addAll([0, 1, 2]);
        }
      } else if (moves[3] == moves[4] &&
          moves[3] == moves[5] &&
          moves[3] != "") {
        winner = moves[3];
        if (winningIndices.isEmpty) {
          winningIndices.addAll([3, 4, 5]);
        }
      } else if (moves[6] == moves[7] &&
          moves[6] == moves[8] &&
          moves[6] != "") {
        winner = moves[6];
        if (winningIndices.isEmpty) {
          winningIndices.addAll([6, 7, 8]);
        }
      } else if (moves[0] == moves[3] &&
          moves[0] == moves[6] &&
          moves[0] != "") {
        winner = moves[0];
        if (winningIndices.isEmpty) {
          winningIndices.addAll([0, 3, 6]);
        }
      } else if (moves[1] == moves[7] &&
          moves[1] == moves[4] &&
          moves[1] != "") {
        winner = moves[1];
        if (winningIndices.isEmpty) {
          winningIndices.addAll([1, 4, 7]);
        }
      } else if (moves[2] == moves[5] &&
          moves[2] == moves[8] &&
          moves[2] != "") {
        winner = moves[2];
        if (winningIndices.isEmpty) {
          winningIndices.addAll([2, 5, 8]);
        }
      } else if (moves[0] == moves[4] &&
          moves[0] == moves[8] &&
          moves[0] != "") {
        winner = moves[0];
        if (winningIndices.isEmpty) {
          winningIndices.addAll([0, 4, 8]);
        }
      } else if (moves[2] == moves[4] &&
          moves[2] == moves[6] &&
          moves[2] != "") {
        winner = moves[2];
        if (winningIndices.isEmpty) {
          winningIndices.addAll([2, 4, 6]);
        }
      }
    });
    resultDeclare();
  }

  void resultDeclare() {
    if (winner == "⭕" && result == "...") {
      setState(() {
        oWins++;
        result = "$player1 wins (⭕).";
      });
    } else if (winner == "❌" && result == "...") {
      setState(() {
        xWins++;
        result = "$player2 wins (❌).";
      });
    } else if (filledBoxes == 9 && result == "...") {
      setState(() {
        result = "There is a Tie.";
      });
    }
  }

  void reset() {
    setState(() {
      winner = "";
      result = "...";
      moves = ["", "", "", "", "", "", "", "", ""];
      oTurn = true;
      filledBoxes = 0;
      winningIndices = [];
    });
  }
}
