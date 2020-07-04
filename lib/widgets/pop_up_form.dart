import 'dart:math';
import 'package:intl/intl.dart';

import 'package:aws_news_app/helper/categories.dart';
import 'package:aws_news_app/helper/news.dart';
import 'package:aws_news_app/models/article.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddArticle extends StatefulWidget {
  AddArticle({
    Key key,
    @required GlobalKey<FormState> formKey,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;

  @override
  _AddArticleState createState() => _AddArticleState();
}

class _AddArticleState extends State<AddArticle> {
  String dropDownValue;
  final Article article = Article(
    id: 0,
    title: "",
    description: "",
    imageUrl: "",
    categroy: "",
    content: "",
    date: DateFormat('yyyy-MM-dd | kk:mm').format(DateTime.now()),
    views: 0,
  );

  @override
  Widget build(BuildContext context) {
    print(dropDownValue);
    article.id = generateArticleId();
    var news = Provider.of<News>(context);
    var categoriesData = Provider.of<Categories>(context);
    var categoriesNames = categoriesData.categories
        .map<String>((cat) => cat.categorieName)
        .toList();
    return FlatButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: StatefulBuilder(
                  builder: (BuildContext ctx, StateSetter setState) {
                    return Stack(
                      overflow: Overflow.visible,
                      children: <Widget>[
                        Positioned(
                          right: -15.0,
                          top: -15.0,
                          child: InkResponse(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: CircleAvatar(
                              child: Icon(Icons.close),
                              backgroundColor: Colors.red,
                            ),
                          ),
                        ),
                        Form(
                          key: widget._formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    hintText: "Title",
                                  ),
                                  onSaved: (value) {
                                    article.title = value;
                                  },
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "Please enter title";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: TextFormField(
                                    decoration: InputDecoration(
                                      hintText: "Description",
                                    ),
                                    onSaved: (value) {
                                      article.description = value;
                                    },
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "Please enter description";
                                      }
                                      return null;
                                    }),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: TextFormField(
                                    keyboardType: TextInputType.multiline,
                                    maxLines: null,
                                    decoration: InputDecoration(
                                      hintText: "Content",
                                    ),
                                    onSaved: (value) {
                                      article.content = value;
                                    },
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "Please enter content";
                                      }
                                      return null;
                                    }),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: TextFormField(
                                    decoration: InputDecoration(
                                      hintText: "Image url",
                                    ),
                                    onSaved: (value) {
                                      article.imageUrl = value;
                                    },
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "Please enter image url";
                                      }
                                      return null;
                                    }),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: DropdownButton<String>(
                                  value: dropDownValue,
                                  icon: Icon(Icons.arrow_downward),
                                  iconSize: 24,
                                  elevation: 16,
                                  isDense: true,
                                  onChanged: (newValue) {
                                    setState(() {
                                      dropDownValue = newValue;
                                      article.categroy = dropDownValue;
                                    });
                                    print(article.categroy);
                                  },
                                  items: categoriesNames
                                      .map<DropdownMenuItem<String>>(
                                        (cat) => DropdownMenuItem(
                                          value: cat,
                                          child: Text(cat),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RaisedButton(
                                  child: Text("Submit"),
                                  onPressed: () {
                                    if (widget._formKey.currentState
                                        .validate()) {
                                      widget._formKey.currentState.save();
                                      news.addArticle(article);
                                      Navigator.of(context).pop();
                                    }
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              );
            });
      },
      child: Row(children: [
        Icon(Icons.add),
        Text(
          "Add Article",
          style: TextStyle(color: Colors.black),
        )
      ]),
    );
  }

  int generateArticleId() {
    var news = Provider.of<News>(context).news;
    if (news.length == 0) {
      return 1;
    }
    return 1 + news.map((e) => e.id).toList().reduce(max);
  }
}
