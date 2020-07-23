import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_news/detail_screen.dart';
import 'package:flutter_news/bookmarks/show_bookmarks.dart';
import 'package:sqflite/sqflite.dart';

import 'Posts.dart';
import 'db/database_helper.dart';

class SecondRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SecondPage();
  }
}

class _SecondPage extends State<SecondRoute> {
  List<Posts> listPosts = [];
  Posts posts;

  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Posts> noteList;


  @override
  void initState() {
    super.initState();
    DatabaseReference postRef =
        FirebaseDatabase.instance.reference().child('Post');
    postRef.once().then((DataSnapshot snap) {
      var KEYS = snap.value.keys;
      var DATA = snap.value;
      listPosts.clear();
      for (var individualKey in KEYS) {
        Posts posts = new Posts(
            DATA[individualKey]['tittle'],
            DATA[individualKey]['Desc'],
            DATA[individualKey]['Date'],
            DATA[individualKey]['path']);
        listPosts.add(posts);
      }
      setState(() {
        print(listPosts.length.toString());
      });
    });
  }

  @override
  Widget build(BuildContext context) {



    if (noteList == null) {
      noteList = List<Posts>();
      updateListView();
    }

    return new Scaffold(
        appBar: AppBar(
          title: Text('News Feeds'),
          actions: <Widget>[ IconButton(
            icon: Icon(
              Icons.bookmark,
              color: Colors.white,
            ),
            onPressed: () {

              Navigator.push(context, MaterialPageRoute(builder: (context)=> BookMarkRoute(),
              ));

              // do something
            },
          )],
        ),
        body: Container(
          child: listPosts.length == 0
              ? new Center(
                  child: CircularProgressIndicator(),
                )
              : new ListView.builder(
                  itemCount: listPosts.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: new InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailsScreen(),
                              // Pass the arguments as part of the RouteSettings. The
                              // DetailScreen reads the arguments from these settings.
                              settings: RouteSettings(
                                arguments: listPosts[index],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.only(bottom: 5),
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                child: FadeInImage.assetNetwork(
                                  placeholder: 'assets/loading.png',
                                  image: listPosts[index].path,
                                ),
                              ),
                              new Padding(padding: EdgeInsets.all(5)),
                              Text(
                                listPosts[index].tittle,
                                style: TextStyle(color: Colors.black),
                                textAlign: TextAlign.start,
                              ),
                              new Padding(padding: EdgeInsets.all(5)),
                              Text(
                                listPosts[index].Date,
                                style: TextStyle(color: Colors.black),
                                textAlign: TextAlign.left,
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
        ));
  }
  void updateListView() {


    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {

      Future<List<Posts>> noteListFuture = databaseHelper.getNoteList();
      noteListFuture.then((noteList) {
        setState(() {
          this.noteList = noteList;

        });
      });
    });
  }
}


