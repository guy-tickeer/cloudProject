import 'package:aws_news_app/views/article_view.dart';
import 'package:flutter/material.dart';

class NewsListView extends StatelessWidget {
  const NewsListView({
    Key key,
    @required this.newslist,
  }) : super(key: key);

  final newslist;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ListView.builder(
            itemCount: newslist.length,
            padding: const EdgeInsets.all(20.0),
            itemBuilder: (context, position) {
              return Column(
                children: <Widget>[
                  Divider(height: 20.0),
                  ListTile(
                    title: Text(
                      '${newslist[position].title}',
                      style: TextStyle(
                        fontSize: 22.0,
                        color: Colors.deepOrangeAccent,
                      ),
                    ),
                    subtitle: Text(
                      '${newslist[position].description}',
                      style: new TextStyle(
                        fontSize: 18.0,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    leading: CircleAvatar(
                      backgroundColor: Colors.blueAccent,
                      backgroundImage: NetworkImage(
                          '${newslist[position].urlToImage}'),
                      radius: 30.0,
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.details),
                      onPressed: () {
                        Navigator.of(context).pushNamed(ArticleView.routeName, arguments: newslist[position]);
                      },
                    ),
                  ),
                ],
              );
            }),
      );
  }
}