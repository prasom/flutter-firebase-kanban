


class MainProjectModel {
  final int id;
  final String projectName;
  final String projectCode;
  final String projectDuration;
  final int projectBudget;
  final String projectDetail;

  MainProjectModel({this.id, this.projectName, this.projectCode, this.projectDuration, this.projectBudget, this.projectDetail});

  factory MainProjectModel.fromJson(Map<String, dynamic> json) {
    return MainProjectModel(
      id: json['id'],
      projectName: json['projectName'],
      projectCode: json['projectCode'],
      projectDuration: json['projectDuration'],
      projectBudget: json['projectBudget'],
      projectDetail: json['projectDetail'],
    );
  }
}
