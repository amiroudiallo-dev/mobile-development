
// ignore_for_file: unused_local_variable, no_leading_underscores_for_local_identifiers, unused_element

import 'package:flutter/material.dart';
import 'package:go_moon/pages/custom_dropdown_button.dart';

class HomePage extends StatelessWidget {
  late double _deviceHeight, _deviceWidth;
  //constructor.
  HomePage({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: _deviceHeight,
          width: _deviceWidth,
          padding: EdgeInsets.symmetric(horizontal: _deviceWidth * 0.035),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _pageTitle(),
                  _bookRideWidget(),
                ],
              ),
            Align(
              // alignment: Alignment.centerRight,
              child:  _astroImageWidget()
            )
          ],
          )
        )
      )
    );
  }

// cette fonction retourne une image comme fond de l'app.
  Widget _astroImageWidget() {
    return Container(
        height: _deviceHeight * 0.35,
        width: _deviceWidth,
        margin: const EdgeInsets.only(bottom: 180),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.black,
          image: const DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("/Users/user/mobile-development/flutter-learning/go_moon/assets/images/astro_moon-2.png"))
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

// this function return a drop-down widget.
  Widget _destinationDropDownWidget() {
    return CustomDropDownButtonClass(
      values: const ['Seatle', 'California', 'Canada'],
      width: _deviceWidth
    );
    
  }

  Widget _travellersInformationWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomDropDownButtonClass(
          values: const ['1', '2', '3', '4', '5'],
          width: _deviceWidth * 0.35
        ),
        CustomDropDownButtonClass(
          values: const ['Economic', 'Bussiness', 'First', 'Second'],
          width: _deviceWidth * 0.50
        ),
      ],
    );
  }

  Widget _bookRideWidget() {
    return Container(
      height: _deviceHeight * 0.25, 
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          _destinationDropDownWidget(),
          _travellersInformationWidget(),
          _rideButton(),
        ],
      ),
    );
  }

  Widget _rideButton() {
    return Container(
      width: _deviceWidth,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.only(bottom: _deviceHeight * 0.025),
      child: MaterialButton(
        onPressed: () {},
        child: const Text(
          "Book Ride!", 
          style: TextStyle(
            color: Colors.black
          ),
        ),
      ),
    );
  }

}