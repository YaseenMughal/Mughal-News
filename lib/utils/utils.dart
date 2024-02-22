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

  static Widget appLoading() {
    return const SpinKitFadingFour(
      color: Colors.teal,
      size: 40.0,
    );
  }

  static richTexted({String? title, String? subTitle, Color? titleColor, Color? subTitleColor}) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(text: title, style: TextStyle(fontSize: 16.0, fontFamily: "Ubuntu", color: titleColor ?? AppColor.blackColor.withOpacity(0.5), fontWeight: FontWeight.w600)),
      TextSpan(text: subTitle, style: TextStyle(fontSize: 13.0, fontFamily: "Ubuntu", color: subTitleColor ?? AppColor.blackColor.withOpacity(0.5), fontWeight: FontWeight.w400))
    ]));
  }

  static appDivider({Color? color, double? thickness, double? indent, double? endIndent}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 0.0),
      child: Divider(
        indent: indent ?? 0.0,
        endIndent: endIndent ?? 0.0,
        color: color ?? AppColor.greyColor,
        thickness: thickness ?? 2.0,
      ),
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

  static TextStyle splashTextStyle = TextStyle(
    fontSize: 20,
    fontFamily: "Ubuntu",
    color: Colors.grey.shade500,
    letterSpacing: .6,
    fontWeight: FontWeight.w400,
    shadows: [
      Shadow(
        color: Colors.black.withOpacity(0.2), // Shadow color and opacity
        offset: const Offset(2, 2), // Shadow position
        blurRadius: 2, // Shadow blur radius
      ),
    ],
  );
}
