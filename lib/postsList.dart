import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:magpie_App/main.dart';
import './services/graphQLConf.dart';
import './services/mutations.dart';
import './services/queries.dart';

class PostsList extends StatefulWidget {
  final String arguments;
  PostsList({Key key, this.arguments}) : super(key: key);
  @override
  _PostsListState createState() => _PostsListState();
}

class _PostsListState extends State<PostsList> {
  Queries queries = Queries();
  GraphQLClient _client = graphQLConfiguration.clientToQuery();
  //String userToken = onGenerated
  // QueryResult result = await _client.query(QueryOptions(
  //   documentNode: gql(queries.getMe(name)),
  // ));

  Future<QueryResult> userResult;

  Future<QueryResult> callUser(token) async {
    Queries queries = Queries();
    GraphQLClient _client = graphQLConfiguration.clientToQuery();
    QueryResult result = await _client.query(QueryOptions(
      documentNode: gql(queries.getMe(token)),
    ));
    return result;
  }

  int testButton() {
    print(widget.arguments);
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? Scaffold(
            appBar: AppBar(
              title: Center(
                child: Text('Feed'),
              ),
            ),
            floatingActionButton: FloatingActionButton(
                elevation: 5, child: Icon(Icons.add), onPressed: null),
            body: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Olá user:',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '<data>',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Container(
                    // child: ListView.builder(
                    //   itemBuilder: (context, index) {
                    //     return Card(
                    //       margin: EdgeInsets.all(5),
                    //       child: Row(
                    //         children: <Widget>[
                    //           ListTile(
                    //             //isThreeLine: true,
                    //             title: Text('≤User≥'),
                    //             subtitle: Text('Text of posts'),
                    //             trailing: Text('date of the post'),
                    //           ),
                    //         ],
                    //       ),
                    //     );
                    //   },
                    // ),
                    )
              ],
            ),
          )
        : CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: Text('Feed'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  GestureDetector(
                    child: Icon(CupertinoIcons.add),
                    onTap: () => 1,
                  )
                ],
              ),
            ),
            resizeToAvoidBottomInset: true,
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Olá user:',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '<data>',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Container(
                    //   child: ListView.builder(
                    //     itemBuilder: (context, index) {
                    //       return Card(
                    //         margin: EdgeInsets.all(5),
                    //         child: ListTile(
                    //           isThreeLine: true,
                    //           title: Text('≤User≥'),
                    //           subtitle: Text('Text of posts'),
                    //           trailing: Text('date of the post'),
                    //         ),
                    //       );
                    //     },
                    //   ),
                    )
              ],
            ),
          );
  }
}
