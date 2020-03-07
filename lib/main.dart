import 'package:flutter/material.dart';
import 'package:flutter_app_3_peliculas/src/pages/home_page.dart';
import 'package:flutter_app_3_peliculas/src/pages/movie_detail.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Peliculas',
      initialRoute: '/',
      routes: {
        '/' : (BuildContext context) => HomePage(),
        'detail' : (BuildContext context) => MovieDetail()
      },
    );
  }
}
