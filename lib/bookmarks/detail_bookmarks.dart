import 'package:flutter/material.dart';
import 'package:flutter_news/db/database_helper.dart';
import 'package:flutter_news/bookmarks/show_bookmarks.dart';
import '../Posts.dart';

class DetailsBookmarkRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DetailsBookmarkScreen();
  }
}

class DetailsBookmarkScreen extends State<DetailsBookmarkRoute> {
  @override
  Widget build(BuildContext context) {
    Posts todo = ModalRoute.of(context).settings.arguments;

    // Use the Todo to create the UI.
    return Scaffold(
        appBar: AppBar(
          title: Text('Details'),
          actions: <Widget>[
            new IconButton(
              onPressed: () async {
                _showMyDialog(context, todo.id);
              },
              icon: Icon(
                Icons.delete,
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

  Future<void> _showMyDialog(BuildContext context, int id) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('AlertDialog'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[

                Text('Do you want to Delete?'),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FlatButton(
                  child: Text('Delete'),
                  onPressed: () {
                    delete(id);
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  child: Text('Cancel'),
                  onPressed: () {

                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          ],
        );
      },
    );
  }

  delete(int id) async {
    var db = DatabaseHelper();
    int result = await db.deletePost(id);
    print(result.toString());
  }
}
