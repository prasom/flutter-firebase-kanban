import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mea_smart_project_management/models/fb_projects_model.dart';
import 'package:mea_smart_project_management/widgets/sub_project_file_list_widget.dart';

class SubProjectFilePage extends StatelessWidget {
  final FBProject project;
  final String mainProjectId;

  const SubProjectFilePage(
      {Key key, @required this.project, @required this.mainProjectId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SubProjectFileListWidget(
      mainId: mainProjectId,
      subId: project.id,
    );
  }
}
