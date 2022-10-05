import '../../config/intentFiles/button_intents.dart';
import '../common/controller/global_controller.dart';
import '../common/controller/intent_controllers.dart';
import 'package:flutter/material.dart';

import '../movie_list/controller/movie_controller.dart';
import '../movie_list/widgets/movies_tile.dart';

class Search extends StatelessWidget {
  const Search({
    Key? key,
    required GlobalController globalController,
    required IntentController intentController,
    required this.mController,
  })  : _globalController = globalController,
        _intentController = intentController,
        super(key: key);

  final GlobalController _globalController;
  final IntentController _intentController;
  final MoviesController mController;

  @override
  Widget build(BuildContext context) {
    return FocusableActionDetector(
        shortcuts: _globalController.navigationIntents,
        actions: <Type, Action<Intent>>{
          LeftbuttonIntent:
              CallbackAction<LeftbuttonIntent>(onInvoke: (intent) {
            if (_intentController.searchIndex <
                mController.localSearch.length - 1) {
              FocusScope.of(context).requestFocus(_intentController
                  .searchNodes!.value[++_intentController.searchIndex]);
              _intentController.searchNodes!.refresh();
              //setState(() {});
            }
          }),
          RightbuttonIntent:
              CallbackAction<RightbuttonIntent>(onInvoke: (intent) {
            print("something ");
            if (_intentController.searchIndex <
                mController.localSearch.length - 1) {
              FocusScope.of(context).requestFocus(_intentController
                  .searchNodes!.value[++_intentController.searchIndex]);
              _intentController.searchNodes!.refresh();
              //setState(() {});
            }
          }),
        },
        child: MoviesTile(
            title: "",
            nodes: _intentController.searchNodes!,
            borderColor: Colors.grey.withOpacity(0.3),
            scrollController: _intentController.searchScroller.value,
            movie: mController.localSearch,
            onSearch: true));
  }
}
