import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'services/graphQLConf.dart';
import './login.dart';
import './registerUser.dart';
import './postsList.dart';

GraphQLConf graphQLConfiguration = GraphQLConf();
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    GraphQLProvider(
      client: graphQLConfiguration.client,
      child: CacheProvider(child: MyApp()),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoApp(
            title: 'Magpie App',
            debugShowCheckedModeBanner: false,
            theme: CupertinoThemeData(
              primaryColor: CupertinoColors.activeBlue,
            ),
            home: Login(),
            routes: <String, WidgetBuilder>{
              '/login': (BuildContext context) => new Login(),
              '/register': (BuildContext context) => new RegisterUser(),
              '/list': (BuildContext context) => new PostsList(),
            },
          )
        : MaterialApp(
            title: 'Magpie App',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blueGrey,
            ),
            home: Login(),
            routes: <String, WidgetBuilder>{
              '/login': (BuildContext context) => new Login(),
              '/register': (BuildContext context) => new RegisterUser(),
              '/list': (BuildContext context) => new PostsList(),
            },
          );
  }
}
