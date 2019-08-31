import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_native_web/flutter_native_web.dart';
import 'package:webview_flutter/webview_flutter.dart';

class InlineMapWidget extends StatefulWidget {
  final String lat;
  final String long;
  final String colorCode;

  const InlineMapWidget(
      {Key key,
      @required this.lat,
      @required this.long,
      @required this.colorCode})
      : super(key: key);
  @override
  _InlineMapWidgetState createState() => _InlineMapWidgetState();
}

class _InlineMapWidgetState extends State<InlineMapWidget> {
  // WebController webController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // FlutterNativeWeb flutterWebView = new FlutterNativeWeb(
    //   onWebCreated: onWebCreated,
    // );
    final _lat = widget.lat;
    final _long = widget.long;
    final _color = widget.colorCode;
    final frameUrl = "https://www.google.co.th/maps/@$_lat,$_long,17z?hl=th";
    return Container(
      child: new Column(
        children: <Widget>[
          new Container(
            child: new WebView(
              initialUrl: frameUrl,
              javascriptMode: JavascriptMode.unrestricted,
            ),
            height: 300.0,
            width: 500.0,
          ),
        ],
      ),
    );
  }
}
