import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:mea_smart_project_management/models/fb_status_model.dart';

class FirebaseDatabaseUtil {
  DatabaseReference _counterRef;
  DatabaseReference _projectsRef;
  DatabaseReference _statusRef;
  DatabaseReference _personalsRef;
  StreamSubscription<Event> _counterSubscription;
  StreamSubscription<Event> _messagesSubscription;
  FirebaseDatabase database = new FirebaseDatabase();
  int _counter;
  DatabaseError error;

  static final FirebaseDatabaseUtil _instance =
      new FirebaseDatabaseUtil.internal();

  FirebaseDatabaseUtil.internal();

  factory FirebaseDatabaseUtil() {
    return _instance;
  }

  void initState() {
    // Demonstrates configuring to the database using a file
    _counterRef = FirebaseDatabase.instance.reference().child('counter');
    // Demonstrates configuring the database directly

    _projectsRef = database.reference().child('Projects');
    _statusRef = database.reference().child('ProjectStatus');
    _personalsRef = database.reference().child('Departments');
    database.reference().child('counter').once().then((DataSnapshot snapshot) {
      print('Connected to second database and read ${snapshot.value}');
    });
    database.setPersistenceEnabled(true);
    database.setPersistenceCacheSizeBytes(10000000);
    _counterRef.keepSynced(true);
    _counterSubscription = _counterRef.onValue.listen((Event event) {
      error = null;
      _counter = event.snapshot.value ?? 0;
    }, onError: (Object o) {
      error = o;
    });
  }

  DatabaseError getError() {
    return error;
  }

  int getCounter() {
    return _counter;
  }

  DatabaseReference getProject() {
    return _projectsRef;
  }

  DatabaseReference getSubProject(id) {
    return _projectsRef.child(id).child('sub_project');
  }

  DatabaseReference getSubProjectFile(mainiId,subId) {
    return _projectsRef.child(mainiId).child('sub_project').child(subId).child('file_upload');
  }

  DatabaseReference getSubDepartment(mainiId,subId) {
    return _projectsRef.child(mainiId).child('sub_project').child(subId).child('department');
  }

  DatabaseReference getProjectFiles(id) {
    return _projectsRef.child(id).child('file_upload');
  }

  DatabaseReference getStatus() {
    return _statusRef;
  }

  DatabaseReference getPersonals() {
    return _personalsRef;
  }

  addProject(FBProject project) async {
    final TransactionResult transactionResult =
        await _counterRef.runTransaction((MutableData mutableData) async {
      mutableData.value = (mutableData.value ?? 0) + 1;

      return mutableData;
    });

    if (transactionResult.committed) {
      _projectsRef.push().set(<String, String>{
        "project_code": "" + project.project_code,
        "project_name": "" + project.project_name,
        "start_date": "" + project.start_date,
        "status_id": "" + project.status_id,
        "budget": "" + project.budget,
        "detail": "" + project.detail,
        "end_date": "" + project.end_date,
        "lat": "" + project.lat,
        "long": "" + project.long,
        "personal": "" + project.personal,
      }).then((_) {
        print('Transaction  committed.');
      });
    } else {
      print('Transaction not committed.');
      if (transactionResult.error != null) {
        print(transactionResult.error.message);
      }
    }
  }

  void deleteProject(FBProject project) async {
    await _projectsRef.child(project.id).remove().then((_) {
      print('Transaction  committed.');
    });
  }

  void updateProject(id, String statusId) async {
    await _projectsRef.child(id).update({
      "status_id": statusId,
    }).then((_) {
      print('Transaction  committed.');
    });
  }

  void updateSubProject(
      String mainProject, String subProject, String statusId) async {
    await _projectsRef
        .child(mainProject)
        .child('sub_project')
        .child(subProject)
        .update({
      "status_id": statusId,
    }).then((_) {
      print('Transaction  committed.');
    });
  }

  void dispose() {
    // _messagesSubscription.cancel();
    // _counterSubscription.cancel();
  }
}
