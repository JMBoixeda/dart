import 'package:flutter/material.dart';

import '../widgets/emc2_logo.dart';

class SplashEmc2Screen extends StatelessWidget {
  static const routeName = '/emc2-splash-logo';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: EMC2Logo(),
      ),
    );
  }
}
