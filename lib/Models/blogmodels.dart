import 'package:flutter/material.dart';

class BlogModel{

  String title;
  String shortdesC;
  String briefDesc;
  String postedDate;
  String imageUrl;
  BlogModel({@required this.title, @required this.shortdesC, @required this.briefDesc, this.postedDate, this.imageUrl});
}