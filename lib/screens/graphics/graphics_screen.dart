import 'package:flutter/material.dart';

import 'package:emc2/screens/graphics/slider.dart';
import 'package:emc2/screens/graphics/auto_label.dart';
import 'package:emc2/widgets/app_drawer.dart';

class GraphicsScreen extends StatefulWidget {
  static const routeName = '/graphic-slider';

  @override
  _GraphicsScreenState createState() => _GraphicsScreenState();
}

class _GraphicsScreenState extends State<GraphicsScreen> {
  void _handleButtonPress() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Rendimiento')),
      drawer: AppDrawer(),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              SizedBox(height: 250.0, child: SliderLine.withRandomData()),
              SizedBox(height: 250.0, child: DonutAutoLabelChart.withRandomData()),
            ],
          )),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.refresh), onPressed: _handleButtonPress),
    );
  }
}
