import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mughal_news/res/constant/color_constant.dart';

class Utils {
  static Size sizeStyle(BuildContext context, {required double ratio}) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    return Size(width * ratio, height * ratio);
  }

  static toastMessage(String message) {
    Fluttertoast.showToast(
        msg: message, toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: Colors.black, textColor: Colors.white, fontSize: 16.0);
  }

  static loader() {
    const SpinKitFadingFour(
      color: Colors.teal,
      size: 40.0,
    );
  }
}

class AppTextStyle {
  static const TextStyle headingTitleStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w600,
    fontFamily: "Roboto",
    color: AppColor.blackColor,
  );
  static TextStyle splashTextStyle = TextStyle(letterSpacing: .6, color: Colors.grey.shade700, fontFamily: "Ubuntu");
}
