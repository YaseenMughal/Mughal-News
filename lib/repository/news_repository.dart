import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:mughal_news/models/category_news_model.dart';
import 'package:mughal_news/models/news_channel_headlines_model.dart';

class NewsRepository {
// news channel
  Future<NewsChannelHeadlinesModel> fetchNewsChannelHeadlinesApi(String channelName) async {
    String url = 'https://newsapi.org/v2/top-headlines?sources=${channelName}&apiKey=d19456fff0cb4d43a39a76d4c58e9047';
    // 'https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=d19456fff0cb4d43a39a76d4c58e9047';
    // print(url);
    final response = await http.get(Uri.parse(url));
    if (kDebugMode) {
      print("$url\nSuccessfully get channel response");
    }
    // print("Successfully get channel response:-  ${response.body}");
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body.toString());
      return NewsChannelHeadlinesModel.fromJson(body);
    }
    throw Exception("Error");
  }

// news category
  Future<CategoriesNewsModel> fetchCategoriesNewsApi(String category) async {
    String url = 'https://newsapi.org/v2/everything?q=${category}&apiKey=d19456fff0cb4d43a39a76d4c58e9047';
    // print(url);
    final response = await http.get(Uri.parse(url));
    if (kDebugMode) {
      print("$url\nSuccessfully get category response");
    }
    // print("Successfully get category response:-  ${response.body}");
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body.toString());
      return CategoriesNewsModel.fromJson(body);
    }
    throw Exception("Error");
  }
}
