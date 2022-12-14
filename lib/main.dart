import 'package:flutter/material.dart';
import 'views/home_page.dart';
import 'views/movie_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: '20 Best Movies',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const HomePage(title: 'Top 20 Movies'),
        },
        onGenerateRoute: (RouteSettings settings) {
          if (settings.name == '/movie') {
            final arg = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
                builder: (ctx) =>
                    MoviePage(id: arg['id'], title: arg['title']));
          }
          return null;
        });
  }
}
