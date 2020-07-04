import 'package:aws_news_app/helper/input_field.dart';
import 'package:aws_news_app/models/user.dart';
import 'package:aws_news_app/views/admin_page.dart';
import 'package:aws_news_app/views/news_view.dart';
import 'package:aws_news_app/widgets/add_category_form.dart';
import 'package:aws_news_app/widgets/pop_up_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget MyAppBar(BuildContext context) {
  final _formKeyArticle = GlobalKey<FormState>();
  final _formKeyCategory = GlobalKey<FormState>();
  var user = Provider.of<User>(context);
  return AppBar(
    centerTitle: true,
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          "AGS",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
        ),
        Text(
          "News",
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
        )
      ],
    ),
    actions: [
      // user.isAdmin ? AddArticle(formKey: _formKeyArticle) : Text(""),
      // user.isAdmin ? AddCategoryForm(formKey: _formKeyCategory) : Text(""),
      FlatButton(
        onPressed: () {
          user.changeAdmin();
        },
        child: user.isAdmin
            ? Row(
                children: [
                  RaisedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AdminPage()));
                    },
                    child: Text("Admin page"),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Log Out",
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              )
            : Row(
                children: [
                  Icon(Icons.people),
                  Text(
                    "Admin",
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
      ),
    ],
    backgroundColor: Colors.transparent,
    elevation: 0.0,
  );
}
