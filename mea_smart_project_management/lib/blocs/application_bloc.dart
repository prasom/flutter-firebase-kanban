import 'dart:async';
import 'dart:collection';

import 'package:mea_smart_project_management/blocs/bloc_provider.dart';


class ApplicationBloc implements BlocBase {
  @override
  void dispose() {
    // TODO: implement dispose
  }
  ///
  /// Synchronous Stream to handle the provision of the movie genres
  ///
  // StreamController<KanbanTaskListModel> _syncController =
  //     StreamController<KanbanTaskListModel>.broadcast();
  // Stream<KanbanTaskListModel> get outMainProjectModels =>
  //     _syncController.stream;

  // ///
  // StreamController<KanbanTaskListModel> _cmdController =
  //     StreamController<KanbanTaskListModel>.broadcast();
  // StreamSink get getMainProjectModels => _cmdController.sink;

  // ApplicationBloc() {
  //   // Read all genres from Internet
  //   api.getMainProject().then((list) {
  //     _genresList = list;
  //     getMainProjectModels.add(null);
  //   });
  //   _cmdController.stream.listen((_) {
  //     _syncController.sink
  //         .add(_genresList);
  //   });
  // }

  // void dispose() {
  //   _syncController.close();
  //   _cmdController.close();
  // }

  // KanbanTaskListModel _genresList;
}
