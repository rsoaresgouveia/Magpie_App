import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:magpie_App/main.dart';
import './models/user.dart';
import './services/graphQLConf.dart';
import './services/mutations.dart';
import './services/queries.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String token;
  void loging(String name) async {
    Queries queries = Queries();
    GraphQLClient _client = graphQLConfiguration.clientToQuery();
    QueryResult result = await _client.query(QueryOptions(
      documentNode: gql(queries.getMe(name)),
    ));

    setState(() {
      token = result.data;
    });
  }

  static TextEditingController userControll = new TextEditingController();
  static TextEditingController passwordControll = new TextEditingController();
  User user;
  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? Scaffold(
            appBar: AppBar(
              title: Center(
                child: Text('Magpie App'),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      image: DecorationImage(
                        image: AssetImage('./assets/magpie.png'),
                      ),
                    ),
                    width: 250,
                    height: 250,
                  ),
                  Text('Faça o Login'),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(),
                      width: 350,
                      child: TextField(
                        controller: userControll,
                        maxLines: 1,
                        decoration: InputDecoration(
                          labelText: 'Usuário',
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(),
                      width: 350,
                      child: TextField(
                        controller: passwordControll,
                        obscureText: true,
                        maxLines: 1,
                        decoration: InputDecoration(
                          labelText: 'Senha',
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        FlatButton(
                          onPressed: () => null,
                          child: Text('Entrar'),
                        ),
                        FlatButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, '/register'),
                          child: Text('Criar cadastro'),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        : CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: Text('Magpie App'),
              trailing: Row(
                  //mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    GestureDetector(
                      child: Icon(CupertinoIcons.add),
                      onTap: () => null,
                    )
                  ]),
              backgroundColor: CupertinoTheme.of(context).primaryColor,
            ),
            resizeToAvoidBottomInset: true,
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    image: DecorationImage(
                      image: AssetImage('./assets/magpie.png'),
                    ),
                  ),
                  width: 250,
                  height: 250,
                ),
                Text('Faça o Login'),
                Center(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    width: 350,
                    child: CupertinoTextField(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      placeholder: 'Usuário',
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    width: 350,
                    child: CupertinoTextField(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      obscureText: true,
                      placeholder: 'Senha',
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      CupertinoButton(
                        child: Text('Entrar'),
                        onPressed: () => null,
                      ),
                      CupertinoButton(
                        child: Text('Criar cadastro'),
                        onPressed: () =>
                            Navigator.pushNamed(context, '/register'),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
  }
}
