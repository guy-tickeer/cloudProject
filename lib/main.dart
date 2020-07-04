import 'package:aws_news_app/helper/categories.dart';
import 'package:aws_news_app/views/article_view.dart';
import 'package:aws_news_app/views/news_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'helper/news.dart';
import 'models/user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: News(),
        ),
        ChangeNotifierProvider.value(
          value: Categories(),
        ),
        ChangeNotifierProvider.value(
          value: User(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: NewsView(),
        routes: {
          ArticleView.routeName: (ctx) => ArticleView(),
        },
      ),
    );
  }
}
