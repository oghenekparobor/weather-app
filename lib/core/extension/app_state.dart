
import 'package:weather_app_test_foodcourt/core/state/state.dart';

extension AppStateToMsg on AppState {
  String get msg => switch (this) {
        LoadedState(data: var data) => data['message'],
        ErrorState(msg: var msg) => msg
      };

  bool get isError {
    if (this is ErrorState) {
      return true;
    } else {
      return false;
    }
  }
}
