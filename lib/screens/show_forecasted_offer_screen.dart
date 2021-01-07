import 'dart:async';

import 'package:emc2/widgets/forecasted_offer.dart';
import 'package:flutter/material.dart';

import '../widgets/forecasted_offer.dart';
import 'package:emc2/widgets/calculated_offer.dart';

class ShowForecastedOfferScreen extends StatefulWidget {
  static const routeName = '/forecasted-offer';

  @override
  _ShowForecastedOfferScreenState createState() =>
      _ShowForecastedOfferScreenState();
}

class _ShowForecastedOfferScreenState extends State<ShowForecastedOfferScreen> {
  var _isLoading = false;

  Widget changeScreen() {
    Future.delayed(Duration(seconds: 7), () {
      setState(() {
        _isLoading = true;
      });
    });
    return Stack(
      children: [
        Center(child: ForecastedOffer()),
        Center(
            child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
        )),
      ],
    );
  }

  _ShowForecastedOfferScreenState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _isLoading
            ? CalculatedOffer()
            : changeScreen(),
      ),
    );
  }
}
