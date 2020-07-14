import 'dart:io' show Platform;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:magpie_App/main.dart';

import './services/mutations.dart';
import './services/queries.dart';

class RegisterUser extends StatefulWidget {
  @override
  _RegisterUserState createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController userCtrl = TextEditingController();
  TextEditingController psswCtrl = TextEditingController();
  bool hasRegister;
  bool fieldsEmpty;

  creteAlertDialog(BuildContext ctx) {
    return AlertDialog(
      content: Text('Returned a Exception'),
      actions: <Widget>[
        Platform.isAndroid
            ? FlatButton(
                child: Text('Ok'),
                onPressed: () => {Navigator.of(context).pop()},
              )
            : CupertinoButton(
                child: Text('Ok'),
                onPressed: () => {Navigator.of(context).pop()})
      ],
    );
  }

  @override
  void initState() {
    hasRegister = false;
    fieldsEmpty = false;
    super.initState();
  }

  void checkUser(String name) async {
    Queries queries = Queries();
    GraphQLClient _client = graphQLConfiguration.clientToQuery();
    QueryResult result = await _client.query(
      QueryOptions(
        documentNode: gql(queries.getMe(name)),
      ),
    );
    print(result);
    if (result.data) {
      setState(
        () {
          hasRegister = true;
        },
      );
    } else {
      setState(
        () {
          hasRegister = false;
        },
      );
    }
  }

  void addUser(String name, String email, String user, String password) async {
    Mutations mutation = Mutations();
    GraphQLClient _client = graphQLConfiguration.clientToQuery();

    if (name.isNotEmpty &&
        email.isNotEmpty &&
        user.isNotEmpty &&
        password.isNotEmpty) {
      setState(
        () {
          //campos não estão vazios
          fieldsEmpty = false;
        },
      );
      print('Fields are not empty ');
      if (!hasRegister) {
        print('dentro do if \'checkUser\'');
        QueryResult result = await _client.mutate(
          MutationOptions(
            documentNode:
                gql(mutation.registerUser(name, email, user, password)),
          ),
        );
        print('user registrado com sucesso');
        print(result.data);
        setState(
          () {
            //não tem um registro com este token
            hasRegister = false;
          },
        );

        if (result.hasException) {
          print('exception caught');
          creteAlertDialog(context);
        }
      } else {
        setState(
          () {
            //já existe um registro com este token
            hasRegister = true;
          },
        );
        print('existe um user assim');
      }
    } else {
      setState(
        () {
          //campos estão vazios
          fieldsEmpty = true;
        },
      );
      print('Campos estão vazios');
    }
    print('pass through all Ifs and should be disposed');
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? Scaffold(
            appBar: AppBar(
              title: Center(
                child: Text('Registro de Usuário'),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 450,
                    padding: EdgeInsets.all(30),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          TextField(
                            controller: nameCtrl,
                            keyboardType: TextInputType.text,
                            decoration:
                                InputDecoration(labelText: 'Digite seu nome'),
                          ),
                          TextField(
                            controller: emailCtrl,
                            keyboardType: TextInputType.emailAddress,
                            decoration:
                                InputDecoration(labelText: 'Digite seu email'),
                          ),
                          TextField(
                            controller: userCtrl,
                            decoration: InputDecoration(
                                labelText: 'Digite seu usuário'),
                          ),
                          TextField(
                            controller: psswCtrl,
                            obscureText: true,
                            decoration:
                                InputDecoration(labelText: 'Digite sua senha'),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              FlatButton(
                                onPressed: () => {
                                  //checkUser(nameCtrl.text),
                                  addUser(nameCtrl.text, emailCtrl.text,
                                      userCtrl.text, psswCtrl.text),
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                        margin: EdgeInsets.all(10),
                                        child: Text('Cadastrar')),
                                    Icon(Icons.person_add)
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (fieldsEmpty)
                    Center(
                      child: Container(
                        width: double.infinity,
                        margin: EdgeInsets.all(60),
                        child: Text(
                            'Campos vazios! Por favor preencha todos os campos para adicionar o usuário'),
                      ),
                    )
                ],
              ),
            ),
          )
        : CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: Text('Registro de Usuário'),
            ),
            resizeToAvoidBottomInset: true,
            child: Container(
              height: 400,
              padding: EdgeInsets.all(30),
              child: SingleChildScrollView(
                padding: EdgeInsets.only(top: 70),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        height: 10,
                      ),
                      Container(
                        height: 45,
                        child: CupertinoTextField(
                          controller: nameCtrl,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          placeholder: 'Digite seu nome',
                        ),
                      ),
                      Container(
                        height: 10,
                      ),
                      Container(
                        height: 45,
                        child: CupertinoTextField(
                          controller: emailCtrl,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          placeholder: 'Digite seu e-mail',
                        ),
                      ),
                      Container(
                        height: 10,
                      ),
                      Container(
                        height: 45,
                        child: CupertinoTextField(
                          controller: userCtrl,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(1)),
                          ),
                          placeholder: 'Digite seu usuário',
                        ),
                      ),
                      Container(
                        height: 10,
                      ),
                      Container(
                        height: 45,
                        child: CupertinoTextField(
                          controller: psswCtrl,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          placeholder: 'Digite sua senha',
                        ),
                      ),
                      Center(
                        child: CupertinoButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  margin: EdgeInsets.all(10),
                                  child: Text('Cadastrar')),
                              Icon(CupertinoIcons.person_add)
                            ],
                          ),
                          onPressed: () => //checkUser(nameCtrl.text),
                              addUser(nameCtrl.text, emailCtrl.text,
                                  userCtrl.text, psswCtrl.text),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
