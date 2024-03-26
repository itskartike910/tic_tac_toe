import 'package:flutter/material.dart';
import 'package:tic_tac_toe/computer_screen/computer_screen.dart';
import 'package:tic_tac_toe/player_screen/player_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 120,
                width: 360,
                alignment: Alignment.topCenter,
                child: Image.asset(
                  "assets/TicTacToe.png",
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(
                // width: 360,
                height: 160,
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    "About:\nTic Tac Toe is a two-player game played on a 3x3 grid. Players take turns marking a square with their symbol (either ⭕ or ❌). The first player to get three of their symbols in a row (vertically, horizontally, or diagonally) wins the game.",
                    style: TextStyle(
                      color: Color.fromARGB(255, 180, 0, 0),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PlayerScreen()))
                        .then((result) {});
                  },
                  style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Colors.purpleAccent),
                    fixedSize: MaterialStatePropertyAll<Size>(Size(270, 50)),
                  ),
                  child: const Text(
                    'Play With Another Player',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ComputerScreen()))
                        .then((result) {});
                  },
                  style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Colors.purpleAccent),
                    fixedSize: MaterialStatePropertyAll<Size>(Size(270, 50)),
                  ),
                  child: const Text(
                    'Play With Computer',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
