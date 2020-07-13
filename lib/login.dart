import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:magpie_App/main.dart';
import 'package:magpie_App/postsList.dart';
import './models/user.dart';
import './services/graphQLConf.dart';
import './services/mutations.dart';
import './services/queries.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool wrongLogin = false;
  String token;
  static TextEditingController userC = new TextEditingController();
  static TextEditingController passC = new TextEditingController();
  static TextEditingController emailC = new TextEditingController();
  User user;

  void loging(TextEditingController user, TextEditingController emailC,
      TextEditingController passC) async {
    Mutations mutation = Mutations();
    GraphQLClient _client = graphQLConfiguration.clientToQuery();
    QueryResult result = await _client.mutate(
      MutationOptions(
        documentNode: gql(mutation.login(emailC.text, userC.text, passC.text)),
      ),
    );
    //final List<LazyCacheMap> tokens = (result.data['token'] as List<dynamic>);

    if (userC.text.isNotEmpty &&
        emailC.text.isNotEmpty &&
        passC.text.isNotEmpty) {
      userC.clear();
      emailC.clear();
      passC.clear();
      if (!result.hasException && result.data['login']['token'] != null) {
        print(result.data['login']['token']);
        wrongLogin = false;
        Platform.isAndroid
            ? Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PostsList(
                    arguments: result.data['login']['token'],
                  ),
                ),
              )
            : Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => PostsList(
                    arguments: result.data['login']['token'],
                  ),
                ),
              );
      } else {
        print(result.exception);
        setState(() {
          wrongLogin = true;
        });
      }
    } else {
      print(result.exception);
      setState(() {
        wrongLogin = true;
      });
    }
  }

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
                  if (wrongLogin)
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 5,
                      ),
                      child: Center(
                        child: Text(
                          'Dados incorretos ou vazios, verifique os dados novamente e refaça o login',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(),
                      width: 350,
                      child: TextField(
                        controller: userC,
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
                        controller: emailC,
                        maxLines: 1,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email',
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(),
                      width: 350,
                      child: TextField(
                        controller: passC,
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
                          onPressed: () => {
                            loging(userC, emailC, passC),
                            // userC.clear(),
                            // emailC.clear(),
                            // passC.clear(),
                          },
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
            child: SingleChildScrollView(
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
                  if (wrongLogin)
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 5,
                      ),
                      child: Center(
                        child: Text(
                          'Dados incorretos ou vazios, verifique os dados novamente e refaça o login',
                          style: TextStyle(
                            color: CupertinoColors.destructiveRed,
                          ),
                        ),
                      ),
                    ),
                  Center(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(10),
                      width: 350,
                      child: CupertinoTextField(
                        controller: userC,
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
                        controller: emailC,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        placeholder: 'Email',
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(10),
                      width: 350,
                      child: CupertinoTextField(
                        controller: passC,
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
                            onPressed: () => {
                                  loging(userC, emailC, passC),
                                  // userC.clear(),
                                  // emailC.clear(),
                                  // passC.clear(),
                                }),
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
            ),
          );
  }
}
