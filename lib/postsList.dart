import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import './services/queries.dart';
import './services/mutations.dart';
import './main.dart';
import './models/posts.dart';

class PostsList extends StatefulWidget {
  final String arguments;
  PostsList({Key key, this.arguments}) : super(key: key);
  @override
  _PostsListState createState() => _PostsListState();
}

class _PostsListState extends State<PostsList> {
  String sucess = '';
  bool error = false;
  ScrollController scrC = ScrollController();
  Queries queries = Queries();

  void addPost(TextEditingController title, TextEditingController text,
      String token) async {
    Mutations mutation = Mutations();
    GraphQLClient _clientMutation = graphQLConfiguration.clientToQuery();
    if (title.text.isNotEmpty && text.text.isNotEmpty) {
      QueryResult result = await _clientMutation.mutate(
        MutationOptions(
          documentNode: gql(mutation.newPost(title.text, text.text, token)),
        ),
      );
      title.clear();
      text.clear();
      setState(() {
        sucess = 'Sucesso';
      });
      Navigator.of(context).pop();
    } else {
      setState(() {
        error = true;
      });
    }
  }

  void _addNewPost(BuildContext ctx) {
    TextEditingController titleC = TextEditingController();
    TextEditingController textC = TextEditingController();
    Platform.isAndroid
        ? showMaterialModalBottomSheet(
            context: context,
            builder: (context, scrollController) => SingleChildScrollView(
              child: Container(
                height: 350,
                padding: EdgeInsets.all(10),
                child: Column(children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: TextField(
                      maxLines: 1,
                      controller: titleC,
                      decoration: InputDecoration(
                        labelText: 'Titulo da postagem',
                      ),
                    ),
                  ),
                  Container(
                    height: 5,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: TextField(
                      maxLines: 1,
                      controller: textC,
                      decoration: InputDecoration(
                        labelText: 'Postagem',
                      ),
                    ),
                  ),
                  FlatButton(
                    onPressed: () => {
                      addPost(titleC, textC, widget.arguments),
                    },
                    child: Text('Add Postagem'),
                  ),
                ]),
              ),
            ),
          )
        : showCupertinoModalBottomSheet(
            context: ctx,
            builder: (context, scrollController) => Container(
              height: 250,
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(230, 230, 230, 1),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: CupertinoTextField(
                      maxLines: 1,
                      controller: titleC,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      placeholder: 'Titulo da postagem',
                    ),
                  ),
                  Container(
                    height: 5,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(230, 230, 230, 1),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: CupertinoTextField(
                      maxLines: 5,
                      controller: textC,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      placeholder: 'Postagem',
                    ),
                  ),
                  CupertinoButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.all(10),
                              child: Text('Add Postagem')),
                          Icon(CupertinoIcons.check_mark_circled),
                        ],
                      ),
                      onPressed: () => {
                            addPost(titleC, textC, widget.arguments),
                          }),
                ],
              ),
            ),
          );
  }

  void _stateDialog() {
    setState(() {
      sucess = '';
    });
  }

  VoidCallback refetchQuery;
  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? Query(
            options: QueryOptions(
              documentNode: gql(
                queries.getPosts(),
              ),
            ),
            builder: (QueryResult result,
                {VoidCallback refetch, FetchMore fetchMore}) {
              refetchQuery = refetch;
              return Scaffold(
                appBar: AppBar(
                  title: Center(
                    child: Text('Feed'),
                  ),
                ),
                floatingActionButton: FloatingActionButton(
                  elevation: 5,
                  child: Icon(Icons.add),
                  onPressed: () => _addNewPost(context),
                ),
                body: result.hasException
                    ? Text(
                        result.exception.toString(),
                      )
                    : result.loading
                        ? CircularProgressIndicator()
                        : Stack(
                            children: <Widget>[
                              ListView.builder(
                                controller: scrC,
                                itemCount:
                                    (result.data['posts'] as List<Object>)
                                        .length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    padding: EdgeInsets.all(1),
                                    child: Card(
                                      color: Color.fromRGBO(240, 240, 240, 1),
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Text(
                                                '@' +
                                                    result.data['posts'][index]
                                                        ['author']['username'],
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                ' - ' +
                                                    result.data['posts'][index]
                                                        ['author']['name'],
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                          Text(
                                            result.data['posts'][index]
                                                ['title'],
                                          ),
                                          Text(
                                            result.data['posts'][index]['text'],
                                          ),
                                          Text('\n'),
                                          Text(
                                            result.data['posts'][index]
                                                ['createdAt'],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                              if (sucess == 'Sucesso')
                                AlertDialog(
                                  content:
                                      Text('Postagem adicionada Com Sucesso'),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text('Ok'),
                                      onPressed: () => {
                                        _stateDialog(),
                                        refetch(),
                                        fetchMore,
                                      },
                                    )
                                  ],
                                )
                            ],
                          ),
              );
            },
          )
        : Query(
            options: QueryOptions(
              documentNode: gql(
                queries.getPosts(),
              ),
            ),
            builder: (QueryResult result,
                {VoidCallback refetch, FetchMore fetchMore}) {
              refetchQuery = refetch;
              return CupertinoPageScaffold(
                navigationBar: CupertinoNavigationBar(
                  middle: Text('Feed'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      GestureDetector(
                        child: Icon(CupertinoIcons.add),
                        onTap: () => _addNewPost(context),
                      )
                    ],
                  ),
                ),
                resizeToAvoidBottomInset: true,
                child: result.hasException
                    ? Text(
                        result.exception.toString(),
                      )
                    : result.loading
                        ? CircularProgressIndicator()
                        : Stack(
                            children: <Widget>[
                              ListView.builder(
                                controller: scrC,
                                itemCount:
                                    (result.data['posts'] as List<Object>)
                                        .length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    padding: EdgeInsets.all(1),
                                    child: Card(
                                      color: Color.fromRGBO(240, 240, 240, 1),
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Text(
                                                '@' +
                                                    result.data['posts'][index]
                                                        ['author']['username'],
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                ' - ' +
                                                    result.data['posts'][index]
                                                        ['author']['name'],
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                          Text(
                                            result.data['posts'][index]
                                                ['title'],
                                          ),
                                          Text(
                                            result.data['posts'][index]['text'],
                                          ),
                                          Text('\n'),
                                          Text(
                                            result.data['posts'][index]
                                                ['createdAt'],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                              if (sucess == 'Sucesso')
                                CupertinoAlertDialog(
                                  content:
                                      Text('Postagem adicionada Com Sucesso'),
                                  actions: <Widget>[
                                    CupertinoButton(
                                      child: Text('Ok'),
                                      onPressed: () => {
                                        _stateDialog(),
                                        refetch(),
                                        fetchMore,
                                      },
                                    )
                                  ],
                                )
                            ],
                          ),
              );
            },
          );
  }
}
