import 'package:aws_news_app/helper/news.dart';
import 'package:aws_news_app/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'news_grid_view.dart';

class FilteredNewsByCategory extends StatelessWidget {
  final String categoryName;
  static final String routeName = "filteredNewsByCategory";

  FilteredNewsByCategory(this.categoryName);

  @override
  Widget build(BuildContext context) {
    var newsList = Provider.of<News>(context)
        .news
        .where((article) => article.categroy == categoryName)
        .toList();
    return Scaffold(
      appBar: MyAppBar(context),
      body: Container(
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
        ),
      ),
    );
  }
}
