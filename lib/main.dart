import 'package:flutter/material.dart';
import 'package:mughal_news/utils/routes/routes.dart';
import 'package:mughal_news/utils/routes/routesName.dart';
import 'package:mughal_news/res/constant/color_constant.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mughal News',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColor.greyColor),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: RouteName.splash,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
