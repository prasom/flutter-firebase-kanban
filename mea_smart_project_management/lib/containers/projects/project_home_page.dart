import 'package:flutter/material.dart';
import 'package:mea_smart_project_management/containers/projects/project_detail_page.dart';
import 'package:mea_smart_project_management/containers/projects/project_file_page.dart';
import 'package:mea_smart_project_management/containers/projects/project_resource_page.dart';
import 'package:mea_smart_project_management/containers/projects/sub_project_page.dart';
import 'package:mea_smart_project_management/models/fb_projects_model.dart';

class ProjectHomePage extends StatefulWidget {
  final FBProject project;

  const ProjectHomePage({Key key, this.project}) : super(key: key);
  @override
  _ProjectHomePageState createState() => _ProjectHomePageState();
}

class _ProjectHomePageState extends State<ProjectHomePage> {
  int _currentIndex = 0;
  List<Widget> _children = [];

  @override
  void initState() {
    super.initState();
    this._children = [
      new ProjectDetailPage(project: widget.project),
      new ProjectResourcePage(
        project: widget.project,
      ),
      new ProjectFilePage(
        project: widget.project,
      ),
      new SubProjectPage(
        project: widget.project,
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
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            title: Text('โครงการย่อย'),
          ),
        ],
        currentIndex: _currentIndex,
        fixedColor: Colors.blue,
        onTap: onTabTapped,
      ),
    );
  }
}
