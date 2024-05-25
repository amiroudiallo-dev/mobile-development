import 'dart:convert';

import 'package:coincap/pages/DetailsPage.dart';
import 'package:coincap/services/HttpService.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class Homepage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<Homepage> {
  double? _deviceHeight, _deviceWidth;
  String? selectedCoin = "bitcoin";
  HttpService? httpService;

  @override
  void initState() {
    super.initState();
    httpService = GetIt.instance.get<HttpService>();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _selectCoinDropDown(),
            _dataWidgets(),
          ],
        ),
      )),
    );
  }

  Widget _selectCoinDropDown() {
    List<String> coins = ['bitcoin', 'ethereum', 'tether'];
    List<DropdownMenuItem<String>> items = coins
        .map((e) => DropdownMenuItem(
            value: e,
            child: Text(
              e,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 23,
              ),
            )))
        .toList();
    return DropdownButton(
      value: selectedCoin,
      items: items,
      onChanged: (dynamic value) {
        setState(() {
          selectedCoin = value;
        });
      },
      dropdownColor: Colors.amberAccent,
      iconSize: 45,
      icon: const Icon(
        Icons.arrow_drop_down_sharp,
        color: Colors.black87,
      ),
      underline: Container(),
    );
  }

  Widget _dataWidgets() {
    return FutureBuilder(
      future: httpService!.get("/coins/$selectedCoin"),
      builder: (BuildContext context, AsyncSnapshot snapShot) {
        if (snapShot.hasData) {
          Map data = jsonDecode(snapShot.data.toString());
          num price = data["market_data"]["current_price"]["usd"];
          num percentage = data["market_data"]["price_change_percentage_24h"];
          Map exchangesRate = data["market_data"]["current_price"];
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                child: _coinImageWidget(data['image']['small']),
                onDoubleTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return DetailsPage(rates: exchangesRate,);
                  }));
                },
              ),
              _currentPriceWidget(price),
              _percentageChangeWidget(percentage),
              _descriptionCardWidget(data["description"]['en']),
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        }
      },
    );
  }

  Widget _currentPriceWidget(num rate) {
    return Text(
      "${rate.toStringAsFixed(2)} USD",
      style:
          const TextStyle(color: Colors.black87, fontWeight: FontWeight.w700),
    );
  }

  Widget _percentageChangeWidget(num percentage) {
    return Text(
      "${percentage.toString()} %",
      style:
          const TextStyle(color: Colors.black87, fontWeight: FontWeight.w700),
    );
  }

  Widget _coinImageWidget(String imgUrl) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: _deviceHeight! * 0.02),
        height: _deviceHeight! * 0.5,
        width: _deviceWidth! * 0.5,
        decoration: BoxDecoration(
          image: DecorationImage(image: NetworkImage(imgUrl)),
        ));
  }

  Widget _descriptionCardWidget(String description) {
    return Container(
      height: _deviceHeight! * 0.45,
      width: _deviceWidth! * 0.90,
      margin: EdgeInsets.symmetric(vertical: _deviceHeight! * 0.05),
      padding: EdgeInsets.symmetric(
          vertical: _deviceHeight! * 0.01, horizontal: _deviceWidth! * 0.01),
      color: Colors.amberAccent,
      child: Text(
        description,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}
