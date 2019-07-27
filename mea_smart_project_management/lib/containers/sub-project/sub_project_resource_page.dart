import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:mea_smart_project_management/apis/firebase_database_api.dart';
import 'package:mea_smart_project_management/models/fb_projects_model.dart';

class SubProjectResourcePage extends StatefulWidget {
  final FBProject project;
  const SubProjectResourcePage({Key key, @required this.project})
      : super(key: key);
  @override
  _SubProjectResourcePageState createState() => _SubProjectResourcePageState();
}

class _SubProjectResourcePageState extends State<SubProjectResourcePage> {
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
    print("showProject");
    print(widget.project.detail);
    return new FirebaseAnimatedList(
      key: new ValueKey<bool>(_anchorToBottom),
      query: databaseUtil.getPersonals(),
      reverse: _anchorToBottom,
      sort: _anchorToBottom
          ? (DataSnapshot a, DataSnapshot b) => b.key.compareTo(a.key)
          : null,
      itemBuilder: (BuildContext context, DataSnapshot snapshot,
          Animation<double> animation, int index) {
        return new SizeTransition(
          sizeFactor: animation,
          child: showProject(snapshot, widget.project),
        );
      },
    );
  }

  Widget showProject(DataSnapshot res, FBProject project) {
    print("showProject");
    print(project.department);
    // if (widget.project.personal[res.key] == true) {
    if (res == null) {
      return Container(
        child: Center(
          child: Text('ไม่พบหน่วยงาน'),
        ),
      );
    }
    if (res != null &&
        widget.project.department != null &&
        widget.project.department[res.key] == true) {
      return new Card(
        child: ListTile(
          // leading: const Icon(Icons.person),
          title: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  res.value["name"],
                  style: TextStyle(
                      color: Colors.orange.shade300,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
