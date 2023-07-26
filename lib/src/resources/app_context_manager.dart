import 'package:flutter/material.dart';

class AppContextManager {
  AppContextManager._();

  static late BuildContext _appContext;

  static void setAppContext(BuildContext context) => _appContext = context;

  static BuildContext getAppContext() => _appContext;
}
