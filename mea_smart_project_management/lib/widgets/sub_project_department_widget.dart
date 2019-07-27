import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:mea_smart_project_management/apis/firebase_database_api.dart';
import 'package:mea_smart_project_management/widgets/pending_action_widget.dart';

class SubProjectDepartment extends StatefulWidget {
  final String mainId;
  final String subId;

  SubProjectDepartment({Key key, @required this.mainId, @required this.subId})
      : super(key: key);

  _SubProjectDepartmentState createState() => _SubProjectDepartmentState();
}

class _SubProjectDepartmentState extends State<SubProjectDepartment> {
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
    return new StreamBuilder<Event>(
        stream:
            databaseUtil.getSubDepartment(widget.mainId, widget.subId).onValue,
        builder: (BuildContext context, AsyncSnapshot<Event> event) {
          if (!event.hasData) return PendingAction();

          return new Container(
            child: buildDepartmentByData(
                event.data.snapshot.key, event.data.snapshot.value),
          );
        });
    // return new FirebaseAnimatedList(
    //     key: new ValueKey<bool>(_anchorToBottom),
    //     query: databaseUtil.getSubDepartment(widget.mainId, widget.subId),
    //     reverse: _anchorToBottom,
    //     sort: _anchorToBottom
    //         ? (DataSnapshot a, DataSnapshot b) => b.key.compareTo(a.key)
    //         : null,
    //     itemBuilder: (
    //       BuildContext context,
    //       DataSnapshot snapshot,
    //       Animation<double> animation,
    //       int index,
    //     ) {
    //       return new SizeTransition(
    //         sizeFactor: animation,
    //         child: buildDepartmentByData(snapshot.key, snapshot.value),
    //       );
    //     });
  }

  Widget buildDepartmentByData(id, value) {
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
          child: showDeparment(snapshot, id, value),
        );
      },
    );
  }

  Widget showDeparment(DataSnapshot res, id, value) {
    print(id);
    print(value);
    // if (res.key == id && value == true) {
    return new Card(
      child: ListTile(
        // leading: const Icon(Icons.person),
        title: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                value,
                // res.value["name"],
                style: TextStyle(
                    color: Colors.orange.shade300, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
    // } else {
    //   return Container();
    // }
  }
  // }
}
