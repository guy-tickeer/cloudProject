import 'dart:convert';

import 'package:aws_news_app/helper/categories.dart';
import 'package:aws_news_app/helper/news.dart';
import 'package:aws_news_app/models/article.dart';
import 'package:aws_news_app/models/category.dart';
import 'package:aws_news_app/models/user.dart';
import 'package:aws_news_app/views/news_grid_view.dart';
import 'package:aws_news_app/widgets/add_category_form.dart';
import 'package:aws_news_app/widgets/app_bar.dart';
import 'package:aws_news_app/widgets/grid_view_for_news.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'category_card.dart';
import 'filtered_news_by_date.dart';

class NewsView extends StatefulWidget {
  @override
  _NewsViewState createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  List<Article> newslist;
  List<Category> categoriesList;

  var _isLoading = false;

  // @override
  // void initState() {
  //   super.initState();
  // }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  // }
  var pickedDate;
  @override
  Widget build(BuildContext context) {
    var newsData = Provider.of<News>(context);
    newsData.getNews();
    newslist = newsData.news;

    var categoriesData = Provider.of<Categories>(context);
    categoriesData.getCategories();
    categoriesList = categoriesData.categories;
    return Scaffold(
      appBar: MyAppBar(context),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 200,
                  child: GestureDetector(
                    onTap: () {
                      showDatePicker(
                        context: context,
                        initialDate:
                            pickedDate == null ? DateTime.now() : pickedDate,
                        firstDate: DateTime(2018),
                        lastDate: DateTime(2022),
                      ).then((date) {
                        if (date != null) {
                          setState(() {
                            pickedDate = date;
                          });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      FilteredNewsByDate(pickedDate)));
                        }
                      });
                    },
                    child: AbsorbPointer(
                      child: TextFormField(
                        keyboardType: TextInputType.datetime,
                        decoration: InputDecoration(
                          hintText: pickedDate == null
                              ? "Search by date"
                              : pickedDate.toString(),
                          prefixIcon: Icon(Icons.timer),
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          height: 70,
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: categoriesList.length,
                              itemBuilder: (context, index) {
                                return CategoryCard(
                                  imageUrl: categoriesList[index].imageUrl,
                                  categoryName:
                                      categoriesList[index].categorieName,
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                ),

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   mainAxisSize: MainAxisSize.min,
                //   children: [
                //     // Text("Search by date: "),

                //   ],
                // ),
                Flexible(
                  flex: 5,
                  child: GridViewWidget(),
                ),
              ],
            ),
    );
  }
}
