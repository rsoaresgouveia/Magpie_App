// id: ID
// title: String
// text: String
// author: User
// createdAt: String
import 'package:flutter/material.dart';

class Posts {
  dynamic id;
  String title;
  String text;
  String author;
  String createdAt;

  Posts(
      {id,
      @required title,
      @required text,
      @required author,
      @required createdAt}) {
    this.id = id;
    this.title = title;
    this.title = text;
    this.title = author;
    this.title = createdAt;
  }
  getId() {
    return this.id;
  }

  getName() {
    return this.title;
  }

  getEmail() {
    return this.text;
  }

  getUsername() {
    return this.author;
  }

  getPassword() {
    return this.createdAt;
  }
}
