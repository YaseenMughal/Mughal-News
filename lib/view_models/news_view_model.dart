import 'package:mughal_news/models/category_news_model.dart';
import 'package:mughal_news/models/news_channel_headlines_model.dart';
import 'package:mughal_news/repository/news_repository.dart';

class NewsViewModel {
  final _rep = NewsRepository();

// news channel
  Future<NewsChannelHeadlinesModel?> fetchNewsChannelHeadlinesApi(String channelName) async {
    try {
      final response = await _rep.fetchNewsChannelHeadlinesApi(channelName);
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

// news category
  Future<CategoriesNewsModel?> fetchCategoriesNewsApi(String category) async {
    try {
      final response = await _rep.fetchCategoriesNewsApi(category);
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
