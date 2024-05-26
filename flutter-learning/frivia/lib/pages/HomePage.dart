import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frivia/pages/GamePage.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  double? _deviceHeight, _deviceWidth;
  double _currentDifficult = 0;

  final List<String> _difficultyTexts = ['Easy', 'Meduim', 'Hard'];

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: _deviceWidth! * 0.10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _appTitle(),
              _sliderDifficult(),
              _startButton(),
            ],
          ),
        ),
      )),
    );
  }

  Widget _appTitle() {
    return Column(
      children: [
        const Text(
          'Frivia',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 50),
        ),
        Text(
          _difficultyTexts[_currentDifficult.toInt()],
          style: const TextStyle(
              color: Colors.lightBlue,
              fontWeight: FontWeight.bold,
              fontSize: 20),
        )
      ],
    );
  }

  Widget _sliderDifficult() {
    return Slider(
        label: _difficultyTexts[_currentDifficult.toInt()],
        min: 0,
        max: 2,
        divisions: 2,
        value: _currentDifficult,
        activeColor: Colors.blueAccent,
        onChanged: (value) {
          setState(() {
            _currentDifficult = value;
          });
        });
  }

  Widget _startButton() {
    return MaterialButton(
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return GamePage(
            difficultyLevel: _difficultyTexts[_currentDifficult.toInt()].toLowerCase(),
          );
        }));
      },
      color: Colors.blue,
      minWidth: _deviceWidth! * 0.80,
      height: _deviceHeight! * 0.07,
      child: const Text(
        'Start',
        style: TextStyle(
            color: Colors.black, fontSize: 35, fontWeight: FontWeight.bold),
      ),
    );
  }
}
