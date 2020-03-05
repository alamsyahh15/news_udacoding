import 'package:flutter/material.dart';
import 'package:flutter_news_app/ui_page/RegisterLogin/LoginPage.dart';

void main() => runApp(MaterialApp(
  home: LoginPage(),
  debugShowCheckedModeBanner: false,
  theme: ThemeData(
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: Colors.black)
    )
  ),
));
