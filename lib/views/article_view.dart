import 'package:aws_news_app/models/article.dart';
import 'package:aws_news_app/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class ArticleView extends StatelessWidget {
  static const routeName = "/articleview";

  final article;

  ArticleView({this.article});

  @override
  Widget build(BuildContext context) {
    final Article args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: MyAppBar(context),
      body: Column(
        children: <Widget>[
          Center(
            child: Container(
              child: Image.network(
                args.imageUrl,
                fit: BoxFit.cover,
              ),
              width: 400,
              height: 400,
            ),
          ),
          SizedBox(height: 20),
          Text(
            args.title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(height: 20),
          Text(
            args.categroy,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(height: 20),
          Text(
            args.date,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text(
            args.description,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text(args.content),
          SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}
