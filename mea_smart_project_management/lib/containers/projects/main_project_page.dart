import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mea_smart_project_management/apis/firebase_database_api.dart';
import 'package:mea_smart_project_management/models/fb_projects_model.dart';
import 'package:mea_smart_project_management/utils/status_color_util.dart';
import 'package:mea_smart_project_management/widgets/kanban_list_widget.dart';
import 'package:mea_smart_project_management/widgets/pending_action_widget.dart';
import 'package:mea_smart_project_management/widgets/sub_kanban_list_widget.dart';

class MainProjectPage extends StatefulWidget {
  final FBProject project;

  const MainProjectPage({Key key, @required this.project}) : super(key: key);
  @override
  _MainProjectPageState createState() => _MainProjectPageState();
}

class _MainProjectPageState extends State<MainProjectPage> {
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
    return Container(
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage("assets/project_bg.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: showKanban(),
    );
  }

  Widget showKanban() {
    return new StreamBuilder<Event>(
      stream:
          FirebaseDatabase.instance.reference().child('ProjectStatus').onValue,
      builder: (BuildContext context, AsyncSnapshot<Event> event) {
        if (!event.hasData) return PendingAction();
        List<dynamic> schedules = event.data.snapshot.value;
        // Map map = event.data.snapshot.value;
        print(schedules);
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: schedules.length,
          itemBuilder: (BuildContext context, int index) {
            if (schedules[index] == null) {
              return Container();
            }
            return new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                DragTarget<FBProject>(
                  onAccept: (data) {
                    _handleAccept(data, index);
                  },
                  onWillAccept: (data) {
                    return true;
                  },
                  builder: (BuildContext context, List candidateData,
                      List rejectedData) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: new BorderRadius.circular(10),
                      ),
                      margin: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width - 100,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(12),
                            // child: Text(snapshot.data.kanbanList[row].status),
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              // mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                // Expanded(
                                //   child: Chip(
                                //     backgroundColor: Color(
                                //       StatusColorUtil.getColorHexFromStr(
                                //         schedules[index]['status_color']
                                //             .toString(),
                                //       ),
                                //     ),
                                //     label: Text(
                                //       schedules[index]['status_name']
                                //           .toString(),
                                //       overflow: TextOverflow.ellipsis,
                                //       softWrap: true,
                                //     ),
                                //   ),
                                // ),
                                // SizedBox(
                                //   width: 20,
                                // ),
                                // Container(
                                //   width: 40,
                                //   child: IconButton(
                                //     color: Colors.grey,
                                //     icon: Icon(Icons.more_vert),
                                //     onPressed: () {},
                                //   ),
                                // )
                                Expanded(
                                  flex: 4,
                                  child: Container(
                                    // color: Colors.blue,
                                    alignment: Alignment.centerLeft,
                                    child: Chip(
                                      backgroundColor: Color(
                                        StatusColorUtil.getColorHexFromStr(
                                          schedules[index]['status_color']
                                              .toString(),
                                        ),
                                      ),
                                      label: Text(
                                        schedules[index]['status_name']
                                            .toString(),
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: true,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 10,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    // color: Colors.red,
                                    height: 50,
                                    child: IconButton(
                                      color: Colors.grey,
                                      icon: Icon(Icons.more_vert),
                                      onPressed: () {},
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height / 1.7,
                            padding: EdgeInsets.all(10),
                            child: KanbanListWidget(
                              statusId: index,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            );
          },
        );
        // Do something with the list of schedules
      },
    );
  }

  _handleAccept(FBProject data, status) {
    databaseUtil.updateProject(data.id, status.toString());
  }
}
