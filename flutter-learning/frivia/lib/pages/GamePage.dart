import 'package:flutter/material.dart';
import 'package:frivia/providers/HomePageProvider.dart';
import 'package:provider/provider.dart';

class GamePage extends StatelessWidget {
  final String difficultyLevel;
  double? _deviceHeght, _deviceWidth;

  HomePageProvider? _gamePageProvider;

  GamePage({required this.difficultyLevel});

  @override
  Widget build(BuildContext context) {
    _deviceHeght = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider(
      create: (context) => HomePageProvider(context: context, difficultyLevel: difficultyLevel),
      child: _buildUI(),
    );
  }

  Widget _buildUI() {
    return Builder(builder: (context) {
      _gamePageProvider = context.watch<HomePageProvider>();
      if (_gamePageProvider!.questions != null) {
        return Scaffold(
          body: SafeArea(
              child: Container(
            padding: EdgeInsets.symmetric(horizontal: _deviceHeght! * 0.05),
            child: _gameUI(),
          )),
        );
      } else {
        return const Center(
            child: CircularProgressIndicator(
          color: Colors.white,
        ));
      }
    });
  }

  Widget _gameUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _questionText(),
        Column(
          children: [
            _trueButton(),
            SizedBox(
              height: _deviceHeght! * 0.02,
            ),
            _falseButton(),
          ],
        )
      ],
    );
  }

  Widget _questionText() {
    return Text(
      _gamePageProvider!.getCurrentQuestion(),
      style: const TextStyle(
          color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
    );
  }

  Widget _trueButton() {
    return MaterialButton(
      onPressed: () {_gamePageProvider!.answerQuestion('True');},
      color: Colors.green,
      minWidth: _deviceWidth! * 0.80,
      height: _deviceHeght! * 0.08,
      child: const Text(
        "True",
        style: TextStyle(
            color: Colors.black, fontSize: 30, fontWeight: FontWeight.w700),
      ),
    );
  }

  Widget _falseButton() {
    return MaterialButton(
      onPressed: () {_gamePageProvider?.answerQuestion('False');},
      color: Colors.red,
      minWidth: _deviceWidth! * 0.80,
      height: _deviceHeght! * 0.08,
      child: const Text(
        "False",
        style: TextStyle(
            color: Colors.black, fontSize: 30, fontWeight: FontWeight.w700),
      ),
    );
  }
}
