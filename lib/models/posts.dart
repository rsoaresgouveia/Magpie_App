import 'package:flutter/material.dart';
import './user.dart';

class Posts {
  String id;
  String title;
  String text;
  String authorName;
  String authorUser;
  String createdAt;

  Posts(
      {String id,
      String title,
      String text,
      String authorName,
      String authorUser,
      String createdAt}) {
    this.id = id;
    this.title = title;
    this.text = text;
    this.authorName = authorName;
    this.authorUser = authorUser;
    this.createdAt = createdAt;
  }
}
