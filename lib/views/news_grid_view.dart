import 'package:aws_news_app/helper/news.dart';
import 'package:aws_news_app/models/article.dart';
import 'package:aws_news_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'article_view.dart';

class NewsContainer extends StatelessWidget {
  const NewsContainer({
    Key key,
    @required this.context,
    @required this.article,
  }) : super(key: key);

  final BuildContext context;
  final Article article;

  @override
  Widget build(BuildContext context) {
    var news = Provider.of<News>(context);
    var admin = Provider.of<User>(context).isAdmin;
    return Card(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 260.0,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(article.imageUrl))),
                ),
                admin
                    ? IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          news.deleteArticle(article);
                        },
                      )
                    : Container(),
              ],
            ),
          ),
          ListTile(
              title: Align(
                alignment: Alignment.center,
                child: Text(
                  article.title,
                  style: TextStyle(
                      color: Color(0xffEA3556),
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              subtitle: Column(
                children: <Widget>[
                  Text(
                    article.description,
                    style: TextStyle(fontSize: 14.0, color: Colors.black),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Category: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            article.categroy,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      SizedBox(width: 5),
                      Text(
                        "|",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 5),
                      Row(
                        children: [
                          Text(
                            "Publish Date: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            article.date,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      SizedBox(width: 5),
                      Text(
                        "|",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 5),
                      Row(
                        children: [
                          Text(
                            "Views: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            article.views.toString(),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      SizedBox(width: 5),
                      RaisedButton(
                        onPressed: () {
                          news.increaseViews(article);
                          Navigator.of(context).pushNamed(ArticleView.routeName,
                              arguments: article);
                        },
                        textColor: Colors.white,
                        color: Color(0xffEA3556),
                        child: new Text(
                          "Details",
                        ),
                      ),
                    ],
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
