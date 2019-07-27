import 'package:firebase_database/firebase_database.dart';

class FBPersonal {
  String _id;
  String _project_code;
  String _project_name;
  String _start_date;
  String _status_id;
  String _budget;
  String _detail;
  String _end_date;
  String _lat;
  String _long;
  dynamic _personal;

  FBPersonal();

  String get id => _id;
  String get project_code => _project_code;
  String get project_name => _project_name;
  String get start_date => _start_date;
  String get status_id => _status_id;
  String get budget => _budget;
  String get detail => _detail;
  String get end_date => _end_date;
  String get lat => _lat;
  String get long => _long;
  dynamic get personal => _personal;

  FBPersonal.fromSnapshot(DataSnapshot snapshot) {
    _id = snapshot.key;
    _project_code = snapshot.value['project_code'];
    _project_name = snapshot.value['project_name'];
    _start_date = snapshot.value['start_date'];
    _status_id = snapshot.value['status_id'];
    _budget = snapshot.value['budget'];
    _detail = snapshot.value['detail'];
    _end_date = snapshot.value['end_date'];
    _lat = snapshot.value['lat'];
    _long = snapshot.value['long'];
    _personal = snapshot.value['personal'];
  }
}
