import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mea_smart_project_management/models/fb_projects_model.dart';
import 'package:mea_smart_project_management/widgets/file_lis_widget.dart';

class ProjectFilePage extends StatelessWidget {
  final FBProject project;

  const ProjectFilePage({Key key, @required this.project}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FileListWidget(
      id: project.id,
    );
  }
}
