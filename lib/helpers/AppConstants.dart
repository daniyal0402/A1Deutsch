import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vocabulary_client/UI/widgets/loader_widget.dart';

class AppConstants {
  static final primaryColor = Colors.yellow;
  static final backgroundGreyColor = HexColor('#F5F5F5');
  static final whiteColor = HexColor('#FFFFFF');
  static final blackColor = HexColor('#393939');
  static final greenColor = HexColor('#5BDE68');
  static final peachColor = HexColor('#F2A490');
  static final secondaryColor = Colors.red;
  static final appOrangeColor = HexColor("#E9765B");
  static final primaryLightColor = HexColor("#B9D4DB");

  static showLoader(context) {
    Loader.show(
      context,
      isAppbarOverlay: true,
      progressIndicator: MyLoader(),
      overlayColor: Colors.white.withOpacity(0.85),
    );
  }

  static showSnack(context, message, onClosed) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(
          content: Text(message),
          duration: const Duration(seconds: 3),
        ))
        .closed
        .then((value) => onClosed());
  }

  static updateLocaleIfNeeded(f, context) {
    if (f == 'localeEN') {
      EasyLocalization.of(context).setLocale(Locale('en', "EN"));
    } else {
      EasyLocalization.of(context).setLocale(Locale('de', "DE"));
    }
  }
}
