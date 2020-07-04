import 'package:flutter/cupertino.dart';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:aws_news_app/models/category.dart' as prefix;

class Categories with ChangeNotifier {
  List<prefix.Category> categories = [];
  bool isInit = false;

  Future<void> getCategories() async {
    if (!isInit) {
      isInit = true;
      categories = [];
      print("fetching categories");
      var response =
          await http.get("http://3.82.19.115:5000/categories/getCategories");
      var jsonData = jsonDecode(response.body);
      jsonData["categories"].forEach((element) {
        if (element['imageUrl'] != null && element['categoryName'] != null) {
          prefix.Category cat = prefix.Category(
            categorieName: element['categoryName'],
            imageUrl: element['imageUrl'],
          );
          categories.add(cat);
        }
      });

      notifyListeners();
    }
  }

  void addCategory(prefix.Category cat) {
    postHandler(cat, "addCategory").then((value) {
      if (value) {
        categories.add(cat);
        notifyListeners();
      }
    });
  }

  void deleteCategory(String catName) {
    var category = categories.firstWhere((cat) => cat.categorieName == catName);
    postHandler(category, "deleteCategory").then((value) {
      if (value) {
        categories.remove(category);
        notifyListeners();
      }
    });
  }

  Future<bool> postHandler(prefix.Category cat, String postRequest) async {
    String url = "http://localhost:8080/categories/" + postRequest;
    var catAsMap = {
      "categoryName": cat.categorieName,
      "imageUrl": cat.imageUrl,
    };
    var rawJson = jsonEncode(catAsMap);
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
