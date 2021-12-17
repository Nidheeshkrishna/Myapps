import 'package:flutter/cupertino.dart';
import 'package:matsapp/Network/AppUpdateRepo/appUpdateService.dart';
import 'package:native_updater/native_updater.dart';
import 'package:package_info/package_info.dart';

class PackageChecking {
  static String version;

  //static version;

  static void appversion(BuildContext context, String type) {
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      String appName = packageInfo.appName;
      String packageName = packageInfo.packageName;
      version = packageInfo.buildNumber;
      String buildNumber = packageInfo.buildNumber;
      fetchAppUpdateinfo(version, type).then(
        (value) => {
          if (value.updateavailable) {checkVersion(context, value.mustupdate)}
        },
      );
    });
  }

  static Future<void> checkVersion(
      BuildContext context, bool mustupdate) async {
    /// For example: You got status code of 412 from the
    /// response of HTTP request.
    /// Let's say the statusCode 412 requires you to force update
    int statusCode = 412;

    /// This could be kept in our local

    NativeUpdater.displayUpdateAlert(
      context,
      forceUpdate: mustupdate,
      appStoreUrl: 'https://apps.apple.com/in/app/matsapp/id1575534126',
      playStoreUrl:
          'https://play.google.com/store/apps/details?id=in.matsapp.android',
      iOSAlertTitle: "A new Version of Upgrade is Avilable",
      iOSDescription: 'Update MatsApp\n',
      iOSUpdateButtonLabel: 'Upgrade',
    );
  }
}
