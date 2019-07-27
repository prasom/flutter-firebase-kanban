import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TextNumberFormat extends StatelessWidget {
  final String text;
  final String subFix;
  final double size;

  const TextNumberFormat({Key key, this.text, this.subFix, this.size = 10}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final formatter = new NumberFormat("#,###");
    var formatedNumb = "0";
    if (text.isNotEmpty) {
      formatedNumb = formatter.format(double.parse('$text'));
    }
    return Text(
      "$formatedNumb $subFix",
      style: TextStyle(fontSize: size),
    );
  }
}
