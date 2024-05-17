
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(child: Container(
      child: _pageTitle(),
    ));
  }

// cette fonction retourne une image comme fond de l'app.
  Widget _astroImageWidget() {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("/Users/user/mobile-development/flutter-learning/go_moon/assets/images/astro_moon-2.png"))
      ),
    ),
    );
  }
// this function return a widget for page title.
  Widget _pageTitle() {
    return const Text("#GoMoon",
      style: TextStyle(
        color: Colors.white, 
        fontSize: 70,
        fontWeight: FontWeight.w800,
        decoration: TextDecoration.none
    ),);
  }
}