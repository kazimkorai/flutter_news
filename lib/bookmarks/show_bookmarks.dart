import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news/Posts.dart';
import 'package:flutter_news/bookmarks/detail_bookmarks.dart';
import 'package:sqflite/sqflite.dart';

import '../db/database_helper.dart';

class BookMarkRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BookMarkRouteListState();
  }
}

class BookMarkRouteListState extends State<BookMarkRoute> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Posts> postList;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (postList == null) {
      postList = List<Posts>();
      updateListView();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: getNoteListView(),
    );
  }

  Widget getNoteListView() {
    if (postList.length == 0) {
      return new Center(
        child: SizedBox(
          width: 250.0,
          child: TextLiquidFill(
            text: 'NO Bookmarked',
            waveColor: Colors.blueAccent,
            boxBackgroundColor: Colors.white,
            textStyle: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
            boxHeight: 300.0,
          ),
        ),
      );
    } else {
      return ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: new InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailsBookmarkRoute(),
                        settings: RouteSettings(
                          arguments: postList[index],
                        )));
              },
              child: Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(bottom: 5),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      child: FadeInImage.assetNetwork(
                        placeholder: 'assets/loading.png',
                        image: postList[index].path,
                      ),
                    ),
                    new Padding(padding: EdgeInsets.all(5)),
                    Text(
                      postList[index].tittle,
                      style: TextStyle(color: Colors.black),
                      textAlign: TextAlign.start,
                    ),
                    new Padding(padding: EdgeInsets.all(5)),
                    Text(
                      postList[index].Date,
                      style: TextStyle(color: Colors.black),
                      textAlign: TextAlign.left,
                    )
                  ],
                ),
              ),
            ),
          );
        },
      );
    }
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Posts>> noteListFuture = databaseHelper.getNoteList();
      noteListFuture.then((noteList) {
        setState(() {
          this.postList = noteList;
          this.count = noteList.length;
        });
      });
    });
  }
}
