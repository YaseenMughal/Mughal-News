import 'package:flutter/material.dart';
import 'package:mughal_news/utils/routes/routesName.dart';
import 'package:mughal_news/views/category_view.dart';
import 'package:mughal_news/views/home_view.dart';
import 'package:mughal_news/views/news_detail_view.dart';
import 'package:mughal_news/views/splash_view.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.splash:
        return MaterialPageRoute(builder: (context) => const SplashView());
      case RouteName.newsDetail:
        return MaterialPageRoute(builder: (context) => const NewsDetailView());
      case RouteName.category:
        return MaterialPageRoute(builder: (context) => const CategoriesView());
      case RouteName.home:
        return MaterialPageRoute(builder: (context) => const HomeView());

      default:
        return MaterialPageRoute(
          builder: (_) {
            return const Scaffold(
              body: Center(
                child: Text("NO ROUTE DEFINED!"),
              ),
            );
          },
        );
    }
  }
}
