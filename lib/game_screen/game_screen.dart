import 'package:flutter/material.dart';

// ignore: must_be_immutable
class GameScreen extends StatefulWidget {
  String p1, p2;
  GameScreen({super.key, required this.p1, required this.p2});

  @override
  State<GameScreen> createState() => GameScreenState();
}

class GameScreenState extends State<GameScreen> {
  String player1 = "", player2 = "";

  bool oTurn = true;
  int xWins = 0, oWins = 0;
  int filledBoxes = 0;
  String winner = "";
  String result = "...";

  List<String> displayXO = ["", "", "", "", "", "", "", "", ""];
  List<int> winningIndices = [];

  @override
  void initState() {
    super.initState();
    player1 = widget.p1;
    player2 = widget.p2;
    if (player1.isEmpty) {
      player1 = "Player 1";
    }
    if (player2.isEmpty) {
      player2 = "Player 2";
    }
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
                        tapped(index);
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
                              displayXO[index],
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
      if (oTurn && displayXO[index] == "") {
        displayXO[index] = "⭕";
        oTurn = !oTurn;
      } else if (!oTurn && displayXO[index] == "") {
        displayXO[index] = "❌";
        oTurn = !oTurn;
      }
      checkWinner();
    });
  }

  void checkWinner() {
    setState(() {
      if (displayXO[0] == displayXO[1] &&
          displayXO[0] == displayXO[2] &&
          displayXO[0] != "") {
        winner = displayXO[0];
        if (winningIndices.isEmpty) {
          winningIndices.addAll([0, 1, 2]);
        }
      } else if (displayXO[3] == displayXO[4] &&
          displayXO[3] == displayXO[5] &&
          displayXO[3] != "") {
        winner = displayXO[3];
        if (winningIndices.isEmpty) {
          winningIndices.addAll([3, 4, 5]);
        }
      } else if (displayXO[6] == displayXO[7] &&
          displayXO[6] == displayXO[8] &&
          displayXO[6] != "") {
        winner = displayXO[6];
        if (winningIndices.isEmpty) {
          winningIndices.addAll([6, 7, 8]);
        }
      } else if (displayXO[0] == displayXO[3] &&
          displayXO[0] == displayXO[6] &&
          displayXO[0] != "") {
        winner = displayXO[0];
        if (winningIndices.isEmpty) {
          winningIndices.addAll([0, 3, 6]);
        }
      } else if (displayXO[1] == displayXO[7] &&
          displayXO[1] == displayXO[4] &&
          displayXO[1] != "") {
        winner = displayXO[1];
        if (winningIndices.isEmpty) {
          winningIndices.addAll([1, 4, 7]);
        }
      } else if (displayXO[2] == displayXO[5] &&
          displayXO[2] == displayXO[8] &&
          displayXO[2] != "") {
        winner = displayXO[2];
        if (winningIndices.isEmpty) {
          winningIndices.addAll([2, 5, 8]);
        }
      } else if (displayXO[0] == displayXO[4] &&
          displayXO[0] == displayXO[8] &&
          displayXO[0] != "") {
        winner = displayXO[0];
        if (winningIndices.isEmpty) {
          winningIndices.addAll([0, 4, 8]);
        }
      } else if (displayXO[2] == displayXO[4] &&
          displayXO[2] == displayXO[6] &&
          displayXO[2] != "") {
        winner = displayXO[2];
        if (winningIndices.isEmpty) {
          winningIndices.addAll([2, 4, 6]);
        }
      }
    });
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
      displayXO = ["", "", "", "", "", "", "", "", ""];
      oTurn = true;
      filledBoxes = 0;
      winningIndices = [];
    });
  }
}
