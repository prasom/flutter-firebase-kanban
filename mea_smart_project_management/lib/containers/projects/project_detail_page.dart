import 'package:flutter/material.dart';
import 'package:mea_smart_project_management/models/fb_projects_model.dart';
import 'package:mea_smart_project_management/utils/status_color_util.dart';
import 'package:mea_smart_project_management/widgets/inline_map.dart';
import 'package:mea_smart_project_management/widgets/kanban_status_widget.dart';
import 'package:mea_smart_project_management/widgets/text_number_format.dart';
import 'package:mea_smart_project_management/widgets/text_wrap.dart';

class ProjectDetailPage extends StatelessWidget {
  final FBProject project;
  const ProjectDetailPage({Key key, @required this.project}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final labelStyle = TextStyle(fontWeight: FontWeight.bold);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          // Divider(),
          SizedBox(
            height: 10,
          ),
          KanbanStatusWidget(
            statusId: project.status_id,
          ),
          SizedBox(
            height: 10,
          ),
          Divider(),
          Container(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            'รหัสโครงการ: ',
                            style: labelStyle,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Text(project.project_code),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            'ชื่อโครงการ: ',
                            style: labelStyle,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: TextWrapWidget(text: project.project_name),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            'ระยะเวลา: ',
                            style: labelStyle,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Text(project.start_date + '-' + project.end_date),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            'งบประมาณ: ',
                            style: labelStyle,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: TextNumberFormat(
                        text: project.budget,
                        subFix: "บาท",
                        size: 14,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            'รายละเอียด: ',
                            style: labelStyle,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: TextWrapWidget(
                        text: project.detail,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Divider(),
          Column(
            children: <Widget>[
              InlineMapWidget(
                lat: project.lat,
                long: project.long,
                colorCode: StatusColorUtil.getMapColorByStatus(
                  project.status_id.toString(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
