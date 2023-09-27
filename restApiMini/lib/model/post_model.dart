// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';
import 'package:flutter/material.dart';

List<Post> postFromJson(String str) =>
    List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));

String postToJson(List<Post> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Post {
  int userId;
  int? i;
  String title;
  String? body;
  int? id;

  Post({
    required this.userId,
    this.i,
    required this.title,
    this.body,
    required this.id,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        userId: json["userId"],
        i: json["I"],
        title: json["title"],
        body: json["body"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "I": i,
        "title": title,
        "body": body,
        "id": id,
      };
}
