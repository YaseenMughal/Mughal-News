import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mughal_news/res/constant/color_constant.dart';
import 'package:mughal_news/res/constant/image_constant.dart';
import 'package:mughal_news/utils/routes/routesName.dart';
import 'package:mughal_news/utils/utils.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.pushNamedAndRemoveUntil(context, RouteName.home, (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    return Scaffold(
      backgroundColor: AppColor.splashBgColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              AppImage.splashImage,
              fit: BoxFit.cover,
              height: height * .5,
              width: width * 1,
            ),
            SizedBox(height: height * .04),
            Text("TOP HEADLINES", style: AppTextStyle.splashTextStyle),
            SizedBox(height: height * .05),
            Utils.appLoading()
          ],
        ),
      ),
    );
  }
}
