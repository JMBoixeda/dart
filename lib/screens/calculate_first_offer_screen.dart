import 'package:flutter/material.dart';

import 'package:emc2/widgets/emc2_logo.dart';

class CalculateFirstOfferScreen extends StatelessWidget {
  const CalculateFirstOfferScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        EMC2Logo(),
      ]),
    );
  }
}
