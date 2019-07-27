import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_native_web/flutter_native_web.dart';

class InlineMapWidget extends StatefulWidget {
  final String lat;
  final String long;
  final String colorCode;

  const InlineMapWidget({Key key, @required this.lat, @required this.long,@required this.colorCode})
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
    return Container(
      child: new Column(
        children: <Widget>[
          new Container(
            // child: flutterWebView,
            height: 300.0,
            width: 500.0,
          ),
        ],
      ),
    );
  }

  // void onWebCreated(webController) {
  //   final _lat = widget.lat;
  //   final _long = widget.long;
  //   final _color = widget.colorCode;
  //   this.webController = webController;
  //   this.webController.loadUrl("https://gisapi.mea.or.th/embed/landmark?q=$_lat,$_long&pinColor=$_color&z=17&mt=standard&s=true&key=c3c6cdcaf6c320f09150ccc66a764d63&latlonOnly=true");
  //   this.webController.onPageStarted.listen((url) => print("Loading $url"));
  //   this
  //       .webController
  //       .onPageFinished
  //       .listen((url) => print("Finished loading $url"));
  // }
}
