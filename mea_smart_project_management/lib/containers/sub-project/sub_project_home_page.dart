import 'package:flutter/material.dart';
import 'package:mea_smart_project_management/containers/sub-project/sub_project_detail_page.dart';
import 'package:mea_smart_project_management/containers/sub-project/sub_project_file_page.dart';
import 'package:mea_smart_project_management/containers/sub-project/sub_project_resource_page.dart';
import 'package:mea_smart_project_management/models/fb_projects_model.dart';

class SubProjectHomePage extends StatefulWidget {
  final String mainProjectId;
  final FBProject project;

  const SubProjectHomePage(
      {Key key, @required this.project, @required this.mainProjectId})
      : super(key: key);
  @override
  _SubProjectHomePageState createState() => _SubProjectHomePageState();
}

class _SubProjectHomePageState extends State<SubProjectHomePage> {
  int _currentIndex = 0;
  List<Widget> _children = [];

  @override
  void initState() {
    super.initState();
    this._children = [
      new SubProjectDetailPage(project: widget.project),
      new SubProjectResourcePage(
        project: widget.project,
      ),
      new SubProjectFilePage(
        project: widget.project,
        mainProjectId: widget.mainProjectId,
      ),
    ];
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // elevation: 0,
        title: Text(widget.project.project_name),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('รายละเอียด'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            title: Text('หน่วยงาน'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder),
            title: Text('ไฟล์เอกสาร'),
          ),
        ],
        currentIndex: _currentIndex,
        fixedColor: Colors.blue,
        onTap: onTabTapped,
      ),
    );
  }
}
