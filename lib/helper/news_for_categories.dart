import 'package:aws_news_app/helper/categories.dart';
import 'package:flutter/foundation.dart';
import 'package:aws_news_app/models/article.dart';
import 'package:provider/provider.dart';

class NewsForCategorie with ChangeNotifier {
  List<Article> filteredNews = [];
  void filterNews(String category) {
    filteredNews =
        filteredNews.where((article) => article.categroy == category).toList();
  }
}
