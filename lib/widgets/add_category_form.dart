import 'package:aws_news_app/models/category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../helper/categories.dart';

class AddCategoryForm extends StatefulWidget {
  AddCategoryForm({
    Key key,
    @required GlobalKey<FormState> formKey,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;

  @override
  _AddCategoryFormState createState() => _AddCategoryFormState();
}

class _AddCategoryFormState extends State<AddCategoryForm> {
  final Category newCat = Category(
    categorieName: "",
    imageUrl: "",
  );

  @override
  Widget build(BuildContext context) {
    var categoriesData = Provider.of<Categories>(context);
    var categories = categoriesData.categories;
    var categoriesNames =
        categories.map<String>((cat) => cat.categorieName).toList();
    return FlatButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Stack(
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
                                hintText: "Category name",
                              ),
                              onSaved: (value) {
                                newCat.categorieName = value;
                              },
                              validator: (value) {
                                if (categoriesNames.contains(value)) {
                                  return "Category name already exist";
                                }
                                if (value.isEmpty) {
                                  return "Please enter categroy name";
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: "Image url",
                                ),
                                onSaved: (value) {
                                  newCat.imageUrl = value;
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Please enter image url";
                                  }
                                  return null;
                                }),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RaisedButton(
                              child: Text("Submit"),
                              onPressed: () {
                                if (widget._formKey.currentState.validate()) {
                                  widget._formKey.currentState.save();
                                  categoriesData.addCategory(newCat);
                                  Navigator.of(context).pop();
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            });
      },
      child: Row(children: [
        Icon(Icons.add),
        Text(
          "Add Category",
          style: TextStyle(color: Colors.black),
        )
      ]),
    );
    ;
  }
}
