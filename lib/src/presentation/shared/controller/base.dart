import 'package:flutter/foundation.dart';
import 'package:food/src/core/constraints.dart';
import 'package:bot_toast/bot_toast.dart';

class BaseController extends ChangeNotifier {
  AppState _appSate = AppState.Idle;
  AppState get appState => _appSate;

  void setAppState(AppState state) {
    _appSate = state;
    notifyListeners();
  }

  void showToast(String message) {
    BotToast.showText(text: message);
  }

  showLoading() {
    BotToast.showLoading();
  }

  closeloading() {
    BotToast.closeAllLoading();
  }
}
