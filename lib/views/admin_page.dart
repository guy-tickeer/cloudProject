import 'package:aws_news_app/models/user.dart';
import 'package:aws_news_app/widgets/add_category_form.dart';
import 'package:aws_news_app/widgets/app_bar.dart';
import 'package:aws_news_app/widgets/pop_up_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminPage extends StatelessWidget {
  final _formKeyArticle = GlobalKey<FormState>();
  final _formKeyCategory = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var isAdmin = Provider.of<User>(context).isAdmin;
    return Scaffold(
      appBar: MyAppBar(context),
      body: isAdmin
          ? Column(
              children: [
                AddArticle(formKey: _formKeyArticle),
                AddCategoryForm(formKey: _formKeyCategory),
              ],
            )
          : Text("You are not Admin!"),
    );
  }
}
