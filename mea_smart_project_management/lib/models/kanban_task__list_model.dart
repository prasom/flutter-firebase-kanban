


import 'package:mea_smart_project_management/models/kanban_task_model.dart';

class KanbanTaskListModel {
  List<KanbanTaskModel> kanbanList = <KanbanTaskModel>[];

  KanbanTaskListModel({
    this.kanbanList,
  });

  factory KanbanTaskListModel.fromJson(List<dynamic> parsedJson) {
    List<KanbanTaskModel> kanbanList = new List<KanbanTaskModel>();
    kanbanList = parsedJson.map((i) => KanbanTaskModel.fromJson(i)).toList();
    return new KanbanTaskListModel(
      kanbanList: kanbanList,
    );
  }
}
