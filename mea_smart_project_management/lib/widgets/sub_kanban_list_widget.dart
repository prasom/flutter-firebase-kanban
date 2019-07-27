import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:mea_smart_project_management/apis/firebase_database_api.dart';
import 'package:mea_smart_project_management/containers/sub-project/sub_project_home_page.dart';
import 'package:mea_smart_project_management/models/fb_projects_model.dart';
import 'package:mea_smart_project_management/widgets/text_number_format.dart';

class SubKanbanListWidget extends StatefulWidget {
  final statusId;
  final id;

  const SubKanbanListWidget({Key key, this.statusId, this.id})
      : super(key: key);
  @override
  _SubKanbanListWidgetState createState() => _SubKanbanListWidgetState();
}

class _SubKanbanListWidgetState extends State<SubKanbanListWidget> {
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
      query: databaseUtil.getSubProject(widget.id),
      reverse: _anchorToBottom,
      sort: _anchorToBottom
          ? (DataSnapshot a, DataSnapshot b) => b.key.compareTo(a.key)
          : null,
      itemBuilder: (BuildContext context, DataSnapshot snapshot,
          Animation<double> animation, int index) {
        return new SizeTransition(
          sizeFactor: animation,
          child: showProject(snapshot),
        );
      },
    );
  }

  Widget showProject(DataSnapshot res) {
    FBProject projects = FBProject.fromSnapshot(res);
    if (projects.status_id != widget.statusId.toString()) {
      return Container();
    }
    var item = new Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SubProjectHomePage(
                        project: projects,
                        mainProjectId: widget.id,
                      )),
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    projects.project_code,
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.pink.shade300,
                    ),
                  ),
                  Text(
                    projects.start_date + ' - ' + projects.end_date,
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey,
                    ),
                  ),
                  TextNumberFormat(
                    text: projects.budget,
                    subFix: "บาท",
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Text(
                  projects.project_name,
                  style: TextStyle(color: Colors.orange.shade300),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    return new LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return LongPressDraggable(
          feedback: new Opacity(
            opacity: 0.75,
            child: new SizedBox(
              width: constraints.maxWidth,
              child: item,
            ),
          ),
          childWhenDragging: new Container(),
          // onDragStarted: () {
          //   Scaffold.of(context).showSnackBar(
          //     new SnackBar(content: new Text("Drag the row to change places")),
          //   );
          // },
          child: item,
          data: projects,
        );
      },
    );
  }
}
