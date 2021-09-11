import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:vocabulary_client/UI/screens/DownloadingData.dart';
import 'package:vocabulary_client/UI/screens/Splash.dart';
import 'package:vocabulary_client/helpers/AppConstants.dart';
import 'package:vocabulary_client/models/AppUser.dart';
import 'package:vocabulary_client/repo/user_repo.dart';
import 'package:easy_localization/easy_localization.dart';

class AccessCodeController extends ControllerMVC {
  String code;
  AppUser user;
  proceedToNext() async {
    if (code == null || code == '') {
      AppConstants.showSnack(context, "Invalid code".tr(), () {});
    } else {
      AppConstants.showLoader(context);
      user = await getUserByCode(code);
      Loader.hide();
      if (user.accessCode == null) {
        AppConstants.showSnack(context, "Invalid code".tr(), () {});
      } else {
        await setUser(user);
        currentUser.value = user;
        // await setFetch(true);
        await setLanguage(user.language);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return DownloadingData();
        }));
      }
    }
  }
}
