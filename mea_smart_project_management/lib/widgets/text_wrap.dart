import 'package:flutter/material.dart';

class TextWrapWidget extends StatelessWidget {
  final String text;

  const TextWrapWidget({Key key, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width * 0.8 - 100;

    return new Container(
      padding: const EdgeInsets.all(0),
      width: c_width,
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text(text, textAlign: TextAlign.left),
        ],
      ),
    );
  }
}
