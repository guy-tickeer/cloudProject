import 'package:aws_news_app/helper/categories.dart';
import 'package:aws_news_app/models/user.dart';
import 'package:aws_news_app/views/filtered_news_by_category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'category_news_view.dart';

class CategoryCard extends StatelessWidget {
  final String imageUrl, categoryName;

  CategoryCard({this.imageUrl, this.categoryName});

  @override
  Widget build(BuildContext context) {
    var admin = Provider.of<User>(context).isAdmin;
    var categories = Provider.of<Categories>(context);
    return Stack(children: [
      Center(
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        FilteredNewsByCategory(categoryName)));
          },
          child: Center(
            child: Container(
              margin: EdgeInsets.only(right: 14),
              child: Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      width: 120,
                      height: 60,
                      child: Image.network(
                        imageUrl,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 60,
                    width: 120,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.black26),
                    child: Text(
                      categoryName,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      admin
          ? Align(
              alignment: Alignment.bottomLeft,
              child: IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: () {
                  categories.deleteCategory(categoryName);
                },
              ),
            )
          : Container(),
    ]);
  }
}
