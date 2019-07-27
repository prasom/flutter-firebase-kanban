

import 'package:mea_smart_project_management/models/main_project_list.dart';

class KanbanTaskModel {
  final int id;
  final String status;
  final MainProjectListModel projects;

  KanbanTaskModel({this.id, this.status, this.projects});

  factory KanbanTaskModel.fromJson(Map<String, dynamic> json) {
    return KanbanTaskModel(
      id: json['id'],
      status: json['status'],
      projects: MainProjectListModel.fromJson(json['projects']),
    );
  }
}
