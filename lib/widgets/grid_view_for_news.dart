import 'package:aws_news_app/helper/news.dart';
import 'package:aws_news_app/views/news_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GridViewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var newsList = Provider.of<News>(context).news;
    return Container(
        child: CustomScrollView(
      slivers: <Widget>[
        SliverPadding(
          padding: EdgeInsets.only(top: 8.0),
          sliver: SliverGrid.count(
            childAspectRatio: 1.74,
            crossAxisCount: MediaQuery.of(context).size.width >= 1400
                ? 3
                : MediaQuery.of(context).size.width >= 800 ? 2 : 1,
            mainAxisSpacing: 2.0,
            children: newsList
                .map<Widget>((article) =>
                    NewsContainer(context: context, article: article))
                .toList(),
          ),
        )
      ],
    ));
  }
}
