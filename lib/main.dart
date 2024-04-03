import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  bool isGameOver = false;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  Map<int, int> ticTacToeMap = {
    0: 0,
    1: 0,
    2: 0,
    3: 0,
    4: 0,
    5: 0,
    6: 0,
    7: 0,
    8: 0
  };
  bool isCoin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 3,
            mainAxisSpacing: 3,
            crossAxisCount: 3,
          ),
          itemCount: 9,
          itemBuilder: (_, index) => InkWell(
            child: Visibility(
              visible: isVisible(index),
              replacement: Container(
                color: Colors.black,
                padding: const EdgeInsets.all(20.0),
              ),
              child: Container(
                color: Colors.black,
                padding: const EdgeInsets.all(20.0),
                child: Image.asset(imageRoute(index)),
              ),
            ),
            onTap: () {
              if(ticTacToeMap[index] == 0 && !isGameOver ){
                setState(() {
                  if(isCoin){
                    ticTacToeMap[index] = 1;
                  }else{
                    ticTacToeMap[index] = 2;
                  }
                  isCoin = !isCoin;

                  detectWinner();
                });
              }
            },
          ),
        ),
      ),
    );
  }


  void detectWinner(){
    int player1 = 1;
    int player2 = 2;

    if (isWinner(ticTacToeMap, player1)) {
      isGameOver = true;
      print("Player 1 is the winner!");
    } else if (isWinner(ticTacToeMap, player2)) {
      isGameOver = true;
      print("Player 2 is the winner!");
    } else if (isDraw(ticTacToeMap)) {
      isGameOver = true;
      print("It's a draw!");
    } else {
      print("Game is still ongoing.");
    }
  }
  bool isDraw(Map<int, int> ticTacToeMap) {
    for (int value in ticTacToeMap.values) {
      if (value == 0) {
        return false;
      }
    }
    return true;
  }


  bool isWinner(Map<int, int> ticTacToeMap, int player) {
    List<List<int>> winningCombinations = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8],
      [0, 3, 6], [1, 4, 7], [2, 5, 8],
      [0, 4, 8], [2, 4, 6]
    ];
    for (var combination in winningCombinations) {
      if (ticTacToeMap[combination[0]] == player &&
          ticTacToeMap[combination[1]] == player &&
          ticTacToeMap[combination[2]] == player) {
        return true;
      }
    }
    return false;
  }

  String imageRoute(int index) {
    int? imageState = ticTacToeMap[index];
    if(imageState == 1){
      return "assets/coin.png";
    }
    if(imageState == 2){
      return "assets/close.png";
    }
    return "";
  }

  bool isVisible(int index) {
    if (ticTacToeMap[index] == 0) {
      return false;
    }
    return true;
  }
}
