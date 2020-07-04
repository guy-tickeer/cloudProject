import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:aws_news_app/models/article.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class News with ChangeNotifier {
  List<Article> news = [];
  bool isInit = false;

  Future<void> getNews() async {
    if (!isInit) {
      isInit = true;
      news = [];
      print("fetching news");
      var response = await http.get('http://3.82.19.115:5000/news/getNews');
      var jsonData = jsonDecode(response.body);
      jsonData["newsList"].forEach((element) {
        if (element['imageUrl'] != null && element['description'] != null) {
          Article article = Article(
            id: element['id'],
            title: element['title'],
            description: element['description'],
            imageUrl: element['imageUrl'],
            content: element['content'],
            categroy: element['category'],
            views: element['views'],
            date: element['date'],
          );
          news.add(article);
        }
      });

      notifyListeners();
    }
  }

  void addArticle(Article article) {
    postHandler(article, "addNews").then((value) {
      if (value) {
        news.add(article);
        notifyListeners();
      }
    });
  }

  void deleteArticle(Article article) {
    var article2Delete = news.firstWhere((art) => art.id == article.id);
    postHandler(article, "deleteNews").then((value) {
      if (value) {
        news.remove(article2Delete);
        notifyListeners();
      }
    });
  }

  void increaseViews(Article article) {
    var article2increase = news.firstWhere((art) => art.id == article.id);
    postHandler(article, "increaseViews").then((value) {
      if (value) {
        article2increase.views += 1;
        notifyListeners();
      }
    });
  }

  Future<bool> postHandler(Article article, String postRequest) async {
    String url = "http://localhost:8080/news/" + postRequest;
    var articleAsMap = {};
    if (postRequest == "addNews") {
      articleAsMap.addAll({
        "id": article.id,
        "title": article.title,
        "description": article.description,
        "imageUrl": article.imageUrl,
        "content": article.content,
        "category": article.categroy,
        "views": article.views,
        "date": article.date,
      });
    } else {
      articleAsMap.addAll({"id": article.id});
    }

    var rawJson = jsonEncode(articleAsMap);
    var response = await http.post(
      url,
      body: rawJson,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json'
      },
    );
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == 'ok') {
      return true;
    }
    return false;
  }
}
