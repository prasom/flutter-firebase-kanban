import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mea_smart_project_management/apis/firebase_database_api.dart';
import 'package:mea_smart_project_management/containers/projects/main_project_page.dart';
import 'package:mea_smart_project_management/models/fb_status_model.dart';
import 'package:mea_smart_project_management/utils/status_color_util.dart';
import 'package:mea_smart_project_management/widgets/kanban_list_widget.dart';
import 'package:mea_smart_project_management/widgets/pending_action_widget.dart';

class FBMainProjectPage extends StatefulWidget {
  @override
  _FBMainProjectPageState createState() => _FBMainProjectPageState();
}

class _FBMainProjectPageState extends State<FBMainProjectPage> {
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
    return Scaffold(
      appBar: AppBar(
        // elevation: 1.0,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
        title: Text('Main Porjects'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: MainProjectPage(project: null,)
    );
  }

  Widget showKanban2() {
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Chip(
                                  backgroundColor: Color(
                                    StatusColorUtil.getColorHexFromStr(
                                      schedules[index]['status_color']
                                          .toString(),
                                    ),
                                  ),
                                  label: Text(
                                    schedules[index]['status_name'].toString(),
                                  ),
                                ),
                                IconButton(
                                  color: Colors.grey,
                                  icon: Icon(Icons.more_vert),
                                  onPressed: () {},
                                )
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
            var aaaa = schedules[index];
            print("itemBuilder>>>>>$aaaa");
            if (schedules[index] == null) {
              return Container();
            }
            return new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new DragTarget<FBProject>(
                  onAccept: (data) {
                    // _handleAccept(data, schedules[index]["key"]);
                    print('onAccept >>>>>> $data');
                  },
                  onWillAccept: (data) {
                    // return true;
                    print('onWillAccept >>>>>> $data');
                  },
                  onLeave: (data) {
                    print('onLeave >>>>>> $data');
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Chip(
                                  backgroundColor: Color(
                                    StatusColorUtil.getColorHexFromStr(
                                      schedules[index]['status_color']
                                          .toString(),
                                    ),
                                  ),
                                  label: Text(
                                    schedules[index]['status_name'].toString(),
                                  ),
                                ),
                                IconButton(
                                  color: Colors.grey,
                                  icon: Icon(Icons.more_vert),
                                  onPressed: () {},
                                )
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
            // return new Column(
            //   mainAxisSize: MainAxisSize.min,
            //   children: <Widget>[
            //     DragTarget<FBProject>(
            //       onAccept: (data) {
            //         _handleAccept(data, index);
            //       },
            //       onWillAccept: (data) {
            //         return true;
            //       },
            //       builder: (BuildContext context, List candidateData,
            //           List rejectedData) {
            //         return Container(
            //           decoration: BoxDecoration(
            //             color: Colors.grey.shade300,
            //             borderRadius: new BorderRadius.circular(10),
            //           ),
            //           margin: EdgeInsets.all(10),
            //           width: MediaQuery.of(context).size.width - 100,
            //           child: Column(
            //             mainAxisSize: MainAxisSize.min,
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: <Widget>[
            //               Padding(
            //                 padding: const EdgeInsets.all(12),
            //                 // child: Text(snapshot.data.kanbanList[row].status),
            //                 child: Row(
            //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                   children: <Widget>[
            //                     Chip(
            //                       backgroundColor: Color(
            //                           StatusColorUtil.getColorHexFromStr(
            //                               schedules[index]['status_color'])),
            //                       label: Text(schedules[index]['status_name']
            //                           .toString()),
            //                     ),
            //                     IconButton(
            //                       color: Colors.grey,
            //                       icon: Icon(Icons.more_vert),
            //                       onPressed: () {},
            //                     )
            //                   ],
            //                 ),
            //               ),
            //               Container(
            //                 height: MediaQuery.of(context).size.height / 1.7,
            //                 padding: EdgeInsets.all(10),
            //                 child: KanbanListWidget(
            //                   statusId: index,
            //                 ),
            //               )
            //             ],
            //           ),
            //         );
            //       },
            //     ),
            //   ],
            // );
          },
        );
        // Do something with the list of schedules
      },
    );
  }

  _handleAccept(data, status) {
    databaseUtil.updateProject(data, status.toString());
  }
}
