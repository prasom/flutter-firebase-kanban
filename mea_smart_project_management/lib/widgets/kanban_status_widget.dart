import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mea_smart_project_management/utils/status_color_util.dart';

class KanbanStatusWidget extends StatefulWidget {
  final String statusId;

  const KanbanStatusWidget({Key key, @required this.statusId})
      : super(key: key);
  @override
  _KanbanStatusWidgetState createState() => _KanbanStatusWidgetState();
}

class _KanbanStatusWidgetState extends State<KanbanStatusWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Event>(
        stream: FirebaseDatabase.instance
            .reference()
            .child('ProjectStatus')
            .onValue,
        builder: (BuildContext context, AsyncSnapshot<Event> event) {
          if (!event.hasData) return new Center(child: new Text('Loading...'));
          List<dynamic> statuses = event.data.snapshot.value;
          String statusNam =
              statuses[int.parse(widget.statusId)]['status_name'].toString();
          String statusColor =
              statuses[int.parse(widget.statusId)]['status_color'].toString();
          return Center(
            child: Chip(
              backgroundColor:
                  Color(StatusColorUtil.getColorHexFromStr(statusColor)),
              label: Text('สถานะ: $statusNam'),
            ),
          );
        });
  }
}
