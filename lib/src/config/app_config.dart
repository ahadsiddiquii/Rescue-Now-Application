import 'dart:io';

import 'environment_flavours.dart';

class AppConfig {
  static late final EnvironmentFlavours _environment;

  static late final String _appVersionToShow;
  static const String _appNameBeta = 'V: BetaDev-';
  static const String _appNameStaging = 'V: Beta-';
  static const String _appNameProduction = 'V: ';

  static late final String _appOperatingSystem;
  static const String _platformAndroid = 'ANDROID';
  static const String _platformIos = 'IOS';
  static const String _platformOther = 'OTHER';

  static void init({
    required EnvironmentFlavours environment,
    required String appVersionToShow,
  }) {
    _environment = environment;
    if (_environment == EnvironmentFlavours.development) {
      _appVersionToShow = _appNameBeta + appVersionToShow;
    } else if (_environment == EnvironmentFlavours.staging) {
      _appVersionToShow = _appNameStaging + appVersionToShow;
    } else if (_environment == EnvironmentFlavours.production) {
      _appVersionToShow = _appNameProduction + appVersionToShow;
    } else {
      _appVersionToShow = appVersionToShow;
    }
    if (Platform.isAndroid) {
      _appOperatingSystem = _platformAndroid;
    } else if (Platform.isIOS) {
      _appOperatingSystem = _platformIos;
    } else {
      _appOperatingSystem = _platformOther;
    }
  }

  static EnvironmentFlavours getEnvironment() {
    return _environment;
  }

  static String getAppPlatform() {
    return _appOperatingSystem;
  }

  static String getAppVersionToShow() {
    return _appVersionToShow;
  }
}
