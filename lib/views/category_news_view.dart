// import 'package:aws_news_app/helper/news_for_categories.dart';
// import 'package:aws_news_app/views/article_view.dart';
// import 'package:aws_news_app/views/news_grid_view.dart';
// import 'package:aws_news_app/widgets/app_bar.dart';
// import 'package:aws_news_app/widgets/grid_view_for_news.dart';
// import 'package:flutter/material.dart';

// class CategoryNews extends StatefulWidget {
//   final String newsCategory;

//   CategoryNews({this.newsCategory});

//   @override
//   _CategoryNewsState createState() => _CategoryNewsState();
// }

// class _CategoryNewsState extends State<CategoryNews> {
//   var newslist;
//   bool _loading = true;

//   @override
//   void initState() {
//     getNews();
//     // TODO: implement initState
//     super.initState();
//   }

//   void getNews() async {
//     NewsForCategorie news = NewsForCategorie();
//     await news.getNewsForCategory(widget.newsCategory);
//     newslist = news.news;
//     setState(() {
//       _loading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: MyAppBar(context),
//       body: _loading
//           ? Center(
//               child: CircularProgressIndicator(),
//             )
//           : GridViewWidget(),
//     );
//   }
// }
