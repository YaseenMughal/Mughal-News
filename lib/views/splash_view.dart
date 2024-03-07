import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mughal_news/res/constant/color_constant.dart';
import 'package:mughal_news/res/constant/image_constant.dart';
import 'package:mughal_news/utils/routes/routesName.dart';
import 'package:mughal_news/utils/utils.dart';
import 'package:animate_do/animate_do.dart';

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
            FadeInLeft(
              from: 200,
              child: Image.asset(
                AppImage.splashImage,
                fit: BoxFit.cover,
                height: height * .5,
                width: width * 1,
              ),
            ),
            SizedBox(height: height * .04),
            Text("TOP HEADLINES", style: AppTextStyle.splashTextStyle).animate().rotate(curve: Curves.linear, duration: const Duration(milliseconds: 300)),
            SizedBox(height: height * .05),
            Utils.appLoading()
          ],
        ),
      ),
    );
  }
}
