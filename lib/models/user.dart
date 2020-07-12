import 'package:flutter/material.dart';

class User {
  String id;
  String name;
  String email;
  String username;
  String password;

  User({id, @required name, email, username, @required password}) {
    this.id = id;
    this.name = name;
    this.email = email;
    this.username = username;
    this.password = password;
  }

  getId() {
    return this.id;
  }

  getName() {
    return this.name;
  }

  getEmail() {
    return this.email;
  }

  getUsername() {
    return this.username;
  }

  getPassword() {
    return this.password;
  }
}

// name: String!
// email: String!
// username: String!
// password: String!
