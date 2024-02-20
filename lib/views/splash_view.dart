import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mughal_news/views/home_screen.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const HomeView()), (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 243, 243),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/splash_pic.jpg',
              fit: BoxFit.cover,
              height: height * .5,
              width: width * 1,
            ),
            SizedBox(height: height * .01),
            Text(
              "TOP HEADLINES",
              // style: GoogleFonts.anton(
              //     letterSpacing: .6, color: Colors.grey.shade700),
              style: TextStyle(letterSpacing: .6, color: Colors.grey.shade700, fontFamily: "Ubuntu"),
            ),
            SizedBox(height: height * .05),
            const SpinKitFadingFour(
              color: Colors.teal,
              size: 40.0,
            )
            // const SpinKitChasingDots(
            //   size: 40.0,
            //   color: Colors.teal,
            // )
          ],
        ),
      ),
    );
  }
}
