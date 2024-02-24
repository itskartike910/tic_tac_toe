import 'package:flutter/material.dart';
import 'package:tic_tac_toe/game_screen/game_screen.dart';

class PlayerScreen extends StatelessWidget {
  PlayerScreen({super.key});

  final player1 = TextEditingController();
  final player2 = TextEditingController();

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
                height: 20,
              ),
              const Text(
                "Enter Player 1 Name (⭕)",
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  controller: player1,
                  decoration: const InputDecoration(
                    labelText: "Player 1 Name",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    ),
                    prefixIcon: Icon(
                      Icons.games_outlined,
                      color: Colors.pinkAccent,
                    ),
                  ),
                ),
              ),
              const Text(
                "Enter Player 2 Name (❌)",
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  controller: player2,
                  decoration: const InputDecoration(
                    labelText: "Player 2 Name",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    ),
                    prefixIcon: Icon(
                      Icons.games_outlined,
                      color: Colors.pinkAccent,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GameScreen(
                                  p1: player1.text,
                                  p2: player2.text,
                                ))).then((result) {});
                  },
                  style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Colors.purpleAccent),
                    fixedSize: MaterialStatePropertyAll<Size>(Size(150, 40)),
                  ),
                  child: const Text(
                    'Start Game',
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
