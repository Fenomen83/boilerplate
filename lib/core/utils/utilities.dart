import 'dart:io';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../models/model_alert_dialog.dart';
import '../resources/_r.dart';

import 'general_data.dart';

class Utilities {

  static final _Alerts alerts = _Alerts();

  static Future<bool> isOnline() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      return false;
    }
  }

  static dynamic getUserSp(String id, {dynamic defaultValue}) {
    return GeneralData.hive.get(id, defaultValue: defaultValue);
  }

  static void setUserSp(String id, dynamic value) async {
    return await GeneralData.hive.put(id, value);
  }


  static void restartApp(BuildContext context) {
    Phoenix.rebirth(context);
  }

  static void openStore() async {
    // LaunchReview.launch(androidAppId: AppConfig.playStoreId, iOSAppId: AppConfig.appStoreId);
  }

  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  static void startNewView(BuildContext context, {required String route, bool? isReplace, bool? clearStack, ChangeNotifier? viewModel}) {
    
  }

  static void onBackPressed(BuildContext context, [ChangeNotifier? viewModel]) {
  }


  static Future<void> logout(BuildContext context) async {
    //TODO add logout functions
  }

}

class _Alerts {

  Future<void> showPlatformAlert(BuildContext context, ModelAlertDialog? model) async {
    final result = await showAlertDialog(
      context: context,
      title: R.string.appName,
      message: model!.description,
      barrierDismissible: model.isDismissible!,
      style: AdaptiveStyle.adaptive,
      actions: model.isActiveCancelButton!
          ? [
              AlertDialogAction(
                label: R.string.cancel,
                key: OkCancelAlertDefaultType.cancel,
                textStyle: const TextStyle(color: Colors.grey),
              ),
              AlertDialogAction(label: R.string.ok, key: OkCancelAlertDefaultType.ok)
            ]
          : [AlertDialogAction(label: R.string.ok, key: OkCancelAlertDefaultType.ok)],
    );

    if (result == OkCancelAlertDefaultType.ok && model.onPressedButton != null) model.onPressedButton!();
  }

  void showCloseAppAlert(BuildContext context, {ModelAlertDialog? model}) {}

  void showToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      backgroundColor: R.color.black,
      textColor: R.color.white,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  void hideSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }
  
  void showInSnackBar(GlobalKey<ScaffoldState> scaffoldKey, String value) {
    ScaffoldMessenger.of(scaffoldKey.currentContext!).showSnackBar(SnackBar(content: Text(value)));
  }
}