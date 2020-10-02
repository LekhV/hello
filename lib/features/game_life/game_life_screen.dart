/* DART */
import 'dart:async';

/* FLUTTER */
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/* COMPONENTS */
import 'package:hello/features/game_life/generation.dart';
import 'package:hello/features/game_life/widgets/custom_button_widget.dart';
import 'package:hello/features/game_life/widgets/generation_cells_widget.dart';

import '../../localizations.dart';

class GameLifeScreen extends StatefulWidget {
  GameLifeScreen();

  @override
  _GameLifeScreenState createState() => _GameLifeScreenState();
}

class _GameLifeScreenState extends State<GameLifeScreen> {
  int numberOfGeneration = 10;
  bool isAutomaticPlayGame = false;

  Generation zeroGeneration;
  Generation currentGeneration;

  Timer _timer;

  @override
  initState() {
    super.initState();
    createMatrix();
  }

  @override
  Widget build(BuildContext context) {
    final textOnButton = currentGeneration == null ? "Start game" : "Next step";
    final iconPlayGame = isAutomaticPlayGame ? Icons.stop : Icons.play_arrow;
    final onTapIcon = isAutomaticPlayGame ? stopAutomaticPlayGame : automaticPlayGame;

    return Scaffold(
      appBar: AppBar(
        title: Text("Game  Life"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            GenerationCellsWidget(zeroGeneration.matrix),
            CustomButtonWidget(
              onTap: startGame,
              textOnButton: textOnButton,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(iconPlayGame),
                  onPressed: onTapIcon,
                ),
                IconButton(
                  icon: Icon(Icons.restore),
                  onPressed: updateMatrix,
                ),
              ],
            ),
            if (currentGeneration != null) ...{
              GenerationCellsWidget(currentGeneration.matrix),
            },
            Text(
              AppLocalizations.of(context).title,
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void createMatrix() {
    zeroGeneration = Generation.getRandomGeneration(SIZE);
    currentGeneration = null;
  }

  void updateMatrix() {
    setState(() {
      createMatrix();

      if (_timer != null) {
        _timer.cancel();
      }
      isAutomaticPlayGame = false;
    });
  }

  void startGame() {
    setState(() {
      if (currentGeneration == null) {
        currentGeneration = zeroGeneration.getNextGeneration();
      } else {
        currentGeneration = currentGeneration.getNextGeneration();
      }
    });
  }

  void automaticPlayGame() {
    setState(() {
      isAutomaticPlayGame = true;
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        startGame();

        int aliveCell = 0;

        for (final row in currentGeneration.matrix) {
          aliveCell = row.fold(
              aliveCell, (previousValue, element) => previousValue += element.isAlive ? 1 : 0);
        }

        if (aliveCell == 0 && currentGeneration.matrix.isNotEmpty) {
          stopAutomaticPlayGame();
        }
      });
    });
  }

  void stopAutomaticPlayGame() {
    setState(() {
      isAutomaticPlayGame = false;
      _timer.cancel();
    });
  }
}

const SIZE = 10;
