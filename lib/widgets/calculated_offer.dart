import 'dart:math';

import 'package:flutter/material.dart';

import 'package:emc2/screens/installations_list_screen.dart';

class CalculatedOffer extends StatelessWidget {
  CalculatedOffer({
    Key key,
  }) : super(key: key);

  Random _random = Random.secure();

  final String text = "Su mejor oferta es de ";

  final TextStyle textStyle = TextStyle(
    color: Colors.red,
    fontWeight: FontWeight.bold,
    fontSize: 40,
    fontFamily: 'GloriaHallelujah',
  );

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(25.0),
        width: _textSize(text, textStyle).width + 16,
        height: _textSize(text, textStyle).height * 5,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.red,
            width: 2,
          ),
          color: Colors.amber[500],
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(
            Radius.circular(25.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(2.0, 5.0), //(x,y)
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              '$text ${_random.nextInt(3000)} Euros',
              textAlign: TextAlign.center,
              style: textStyle,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: RaisedButton(
                child: Text('CONTINUAR'),
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed(InstallationsListScreen.routeName);
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).primaryTextTheme.button.color,
              ),
            ),
          ],
        ));
  }

  // Calculate text size
  Size _textSize(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text, style: style),
        maxLines: 3,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);

    return textPainter.size;
  }
}
