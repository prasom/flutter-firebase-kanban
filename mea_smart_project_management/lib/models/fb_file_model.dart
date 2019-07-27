import 'package:firebase_database/firebase_database.dart';

class FBFileProject {
  String _file_name;
  String _file_name_upload;
  String _file_url;

  FBFileProject();

  String get file_name => _file_name;
  String get file_name_upload => _file_name_upload;
  String get file_url => _file_url;

  FBFileProject.fromSnapshot(DataSnapshot snapshot) {
    _file_name = snapshot.value['file_name'];
    _file_name_upload = snapshot.value['file_name_upload'];
    _file_url = snapshot.value['file_url'];
  }

  FBFileProject.fromJson(Map<dynamic, dynamic> json) {
    _file_name = json['file_name'];
    _file_name_upload = json['file_name_upload'];
    _file_url = json['file_url'];
  }
}
