import 'package:flutter/material.dart';
// import 'dart:math';

// ignore: must_be_immutable
class ComputerScreen extends StatefulWidget {
  const ComputerScreen({super.key});

  @override
  State<ComputerScreen> createState() => ComputerScreenState();
}

class ComputerScreenState extends State<ComputerScreen> {
  String player1 = "", player2 = "";

  bool oTurn = true;
  int xWins = 0, oWins = 0, ties = 0;
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
                    // Column(
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    //   children: [
                    //     const Padding(
                    //       padding: EdgeInsets.only(bottom: 12),
                    //       child: Text(
                    //         "Ties",
                    //         textAlign: TextAlign.center,
                    //         style: TextStyle(
                    //             fontWeight: FontWeight.bold,
                    //             fontSize: 24,
                    //             color: Color.fromARGB(255, 2, 2, 151)),
                    //       ),
                    //     ),
                    //     Text(
                    //       ties.toString(),
                    //       style: const TextStyle(
                    //           fontWeight: FontWeight.bold,
                    //           fontSize: 24,
                    //           color: Color.fromARGB(255, 2, 2, 151)),
                    //     ),
                    //   ],
                    // ),
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
      if (oTurn && moves[index] == "") {
        filledBoxes++;
        moves[index] = "⭕";
        oTurn = !oTurn;
        checkWinner();
        if (filledBoxes < 9 && result == "...") {
          Future.delayed(const Duration(seconds: 1), () {
            computerMove();
          });
        }
        checkWinner();
      }
    });
  }

  // void computerMove() {
  //   //Without AI
  //   filledBoxes++;
  //   List<int> emptySpots = [];
  //   for (int i = 0; i < moves.length; i++) {
  //     if (moves[i] == "") {
  //       emptySpots.add(i);
  //     }
  //   }

  //   if (emptySpots.isNotEmpty) {
  //     int randomIndex = Random().nextInt(emptySpots.length);
  //     int computerMoveIndex = emptySpots[randomIndex];
  //     moves[computerMoveIndex] = "❌";
  //     oTurn = !oTurn;
  //     checkWinner();
  //   }
  // }

  void computerMove() {
    //With AI
    filledBoxes++;
    checkWinner();
    setState(() {
      int winningMove = findWinningMove('❌');
      // Check for winning move
      if (winningMove != -1) {
        moves[winningMove] = '❌';
      }
      // Check for blocking move
      else {
        int blockingMove = findWinningMove('⭕');
        if (blockingMove != -1) {
          moves[blockingMove] = '❌';
        }
        // If no winning or blocking move, make a move based on a simple heuristic
        else {
          int bestMove = findBestMove();
          if (bestMove != -1) {
            moves[bestMove] = '❌';
          }
        }
      }
      oTurn = !oTurn;
      checkWinner();
    });
  }

  int findWinningMove(String symbol) {
    // Check rows
    if (moves[0] == symbol && moves[1] == symbol && moves[2] == '') return 2;
    if (moves[0] == symbol && moves[2] == symbol && moves[1] == '') return 1;
    if (moves[1] == symbol && moves[2] == symbol && moves[0] == '') return 0;

    if (moves[3] == symbol && moves[4] == symbol && moves[5] == '') return 5;
    if (moves[3] == symbol && moves[5] == symbol && moves[4] == '') return 4;
    if (moves[4] == symbol && moves[5] == symbol && moves[3] == '') return 3;

    if (moves[6] == symbol && moves[7] == symbol && moves[8] == '') return 8;
    if (moves[6] == symbol && moves[8] == symbol && moves[7] == '') return 7;
    if (moves[7] == symbol && moves[8] == symbol && moves[6] == '') return 6;

    // Check columns
    if (moves[0] == symbol && moves[3] == symbol && moves[6] == '') return 6;
    if (moves[0] == symbol && moves[6] == symbol && moves[3] == '') return 3;
    if (moves[3] == symbol && moves[6] == symbol && moves[0] == '') return 0;

    if (moves[1] == symbol && moves[4] == symbol && moves[7] == '') return 7;
    if (moves[1] == symbol && moves[7] == symbol && moves[4] == '') return 4;
    if (moves[4] == symbol && moves[7] == symbol && moves[1] == '') return 1;

    if (moves[2] == symbol && moves[5] == symbol && moves[8] == '') return 8;
    if (moves[2] == symbol && moves[8] == symbol && moves[5] == '') return 5;
    if (moves[5] == symbol && moves[8] == symbol && moves[2] == '') return 2;

    // Check diagonals
    if (moves[0] == symbol && moves[4] == symbol && moves[8] == '') return 8;
    if (moves[0] == symbol && moves[8] == symbol && moves[4] == '') return 4;
    if (moves[4] == symbol && moves[8] == symbol && moves[0] == '') return 0;

    if (moves[2] == symbol && moves[4] == symbol && moves[6] == '') return 6;
    if (moves[2] == symbol && moves[6] == symbol && moves[4] == '') return 4;
    if (moves[4] == symbol && moves[6] == symbol && moves[2] == '') return 2;

    return -1; // No winning move found
  }

  int findBestMove() {
    // Check for corners
    if (moves[0] == '') return 0;
    if (moves[2] == '') return 2;
    if (moves[6] == '') return 6;
    if (moves[8] == '') return 8;

    // Check for center
    if (moves[4] == '') return 4;

    // Check for edges
    if (moves[1] == '') return 1;
    if (moves[3] == '') return 3;
    if (moves[5] == '') return 5;
    if (moves[7] == '') return 7;

    return -1; // No available move found (shouldn't reach here)
  }

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
        ties++;
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
