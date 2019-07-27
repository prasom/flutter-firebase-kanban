import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mea_smart_project_management/apis/firebase_database_api.dart';
import 'package:mea_smart_project_management/models/fb_file_model.dart';
import 'package:url_launcher/url_launcher.dart';

class SubProjectFileListWidget extends StatefulWidget {
  final String mainId;
  final String subId;

  const SubProjectFileListWidget(
      {Key key, @required this.mainId, @required this.subId})
      : super(key: key);
  @override
  _SubProjectFileListWidgetState createState() =>
      _SubProjectFileListWidgetState();
}

class _SubProjectFileListWidgetState extends State<SubProjectFileListWidget> {
  bool _anchorToBottom = false;
  FirebaseDatabaseUtil databaseUtil;

  @override
  void initState() {
    super.initState();
    databaseUtil = new FirebaseDatabaseUtil();
    databaseUtil.initState();
  }

  @override
  void dispose() {
    super.dispose();
    databaseUtil.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new FirebaseAnimatedList(
        key: new ValueKey<bool>(_anchorToBottom),
        query: databaseUtil.getSubProjectFile(widget.mainId, widget.subId),
        reverse: _anchorToBottom,
        sort: _anchorToBottom
            ? (DataSnapshot a, DataSnapshot b) => b.key.compareTo(a.key)
            : null,
        itemBuilder: (
          BuildContext context,
          DataSnapshot snapshot,
          Animation<double> animation,
          int index,
        ) {
          return new SizeTransition(
            sizeFactor: animation,
            child: buildFileList(snapshot),
          );
        });
  }

  Widget buildFileList(DataSnapshot res) {
    FBFileProject file = FBFileProject.fromSnapshot(res);

    return InkWell(
      onTap: () => _launchURL(file.file_url),
      child: new Card(
        child: ListTile(
          leading: Icon(Icons.file_download),
          title: Text(
            file.file_name,
            style: TextStyle(color: Colors.blueAccent),
          ),
        ),
      ),
    );
  }

  _launchURL(fileUrl) async {
    var url = fileUrl;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
