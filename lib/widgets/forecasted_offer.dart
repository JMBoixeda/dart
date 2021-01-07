import 'package:flutter/material.dart';

class ForecastedOffer extends StatelessWidget {
  ForecastedOffer({Key key, }) : super(key: key);

  final String text = "Buscando su mejor oferta!!";

  final TextStyle textStyle = TextStyle(
    color: Colors.red,
    fontWeight: FontWeight.bold,
    fontSize: 70,
    fontFamily: 'GloriaHallelujah',
  );

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(25.0),
        width: _textSize(text, textStyle).width + 16,
        height: _textSize(text, textStyle).height * 3,
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
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: textStyle,
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
