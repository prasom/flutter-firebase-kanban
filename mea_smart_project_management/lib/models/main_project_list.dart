import 'package:mea_smart_project_management/models/main_project.dart';

class MainProjectListModel {
  List<MainProjectModel> projectList = <MainProjectModel>[];

  MainProjectListModel({
    this.projectList,
  });

  factory MainProjectListModel.fromJson(List<dynamic> parsedJson) {
    List<MainProjectModel> projectList = new List<MainProjectModel>();
    projectList = parsedJson.map((i) => MainProjectModel.fromJson(i)).toList();
    return new MainProjectListModel(
      projectList: projectList,
    );
  }
}
