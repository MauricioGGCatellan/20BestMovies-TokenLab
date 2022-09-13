import 'dart:math';

import 'package:flutter/material.dart';
import 'package:movies_app/components/movie_card.dart';
import 'package:movies_app/view-models/homepage_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  final homepageModel = HomepageModel();
  late Future dataRequest;

  @override
  void initState() {
    super.initState();
    dataRequest = homepageModel.requestData();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    const minWidth = 700.0;
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
            child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: max(screenWidth, minWidth),
                    ),
                    child: FutureBuilder(
                        future: dataRequest,
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return Text('Waiting!');
                            case ConnectionState.done:
                              return ListView.builder(
                                itemCount: homepageModel.ids.length % 2 == 0
                                    ? homepageModel.ids.length ~/ 2
                                    : homepageModel.ids.length ~/ 2 + 1,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          MovieCard(
                                              ranking: index * 2 + 1,
                                              title: homepageModel
                                                  .titles[index * 2],
                                              posterUrl: homepageModel
                                                  .posterUrls[index * 2]),
                                          if (index * 2 + 1 <
                                              homepageModel.ids.length)
                                            MovieCard(
                                                ranking: index * 2 + 1 + 1,
                                                title: homepageModel
                                                    .titles[index * 2 + 1],
                                                posterUrl: homepageModel
                                                    .posterUrls[index * 2 + 1])
                                        ]),
                                  );
                                },
                              );
                            case ConnectionState.active:
                              return Text('Error!');
                            case ConnectionState.none:
                              return Text('Error!');
                          }
                        })))));
  }
}
