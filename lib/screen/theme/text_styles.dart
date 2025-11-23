import 'package:flutter/material.dart';

class AppTextStyle{
  //Special App title
  static const title=TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    fontFamily: "Inter"
  );
  //For app heading ya button text
  static const h1=TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      fontFamily: "Inter"
  );
  //for other heading text
  static const h2=TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      fontFamily: "Inter"
  );

  static const h3=TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    fontFamily: "Inter",
  );

  static const h4=TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.normal,
    fontFamily: "Inter"
  );

  //for title
  static const titleLarge=TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 15,
    fontFamily: "Inter"
  );

  static const titleMedium=TextStyle(
    fontSize: 15,
    fontFamily: "Inter",
      fontWeight: FontWeight.w400
  );

  //body Text
  static const bodyLarge=TextStyle(
    fontWeight: FontWeight.w100,
    fontSize: 13,
    fontFamily: "Inter"
  );

  static const bodyMedium=TextStyle(
    fontWeight:FontWeight.w100,
    fontSize: 12,
    fontFamily: "Inter"
  );

  static const bodySmall=TextStyle(
      fontWeight:FontWeight.w100,
      fontSize: 10,
      fontFamily: "Inter"
  );
}