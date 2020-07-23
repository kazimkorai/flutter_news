import 'package:flutter/material.dart';

import 'Posts.dart';
import 'db/database_helper.dart';

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Posts todo = ModalRoute.of(context).settings.arguments;
    // Use the Todo to create the UI.
    return Scaffold(
        appBar: AppBar(
          title: Text('Details'),
          actions: <Widget>[
            new IconButton(
              onPressed: () {
                var db=DatabaseHelper();
                db.insertPost(todo);
                print(db.getNoteList().toString());
              },
              icon: Icon(
                Icons.bookmark,
                color: Colors.white,
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(5),
                child: Text(
                  todo.tittle,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              new Padding(padding: EdgeInsets.all(5)),
              FadeInImage.assetNetwork(
                placeholder: 'assets/loading.png',
                image: todo.path,
              ),
              new Padding(
                padding: EdgeInsets.all(5),
              ),
              Align(
                child: Text(
                  todo.Date,
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: EdgeInsets.all(5),
                child: Text(
                  todo.Desc,
                  style: TextStyle(fontSize: 16),
                ),
              )
            ],
          ),
        ));
  }
}
