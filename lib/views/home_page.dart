import 'dart:math';

import 'package:flutter/material.dart';
import 'package:movies_app/components/movie_card.dart';
import 'package:movies_app/components/error_sign.dart';
import 'package:movies_app/view-models/homepage_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  final homepageModel = HomepageModel();

  void callback() {
    setState(() {});
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
            child: FutureBuilder(
                future: homepageModel.requestData(),
                builder: (context, snapshot) {
                  if (!snapshot.hasError) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return const Text('Waiting!');
                      case ConnectionState.active:
                      case ConnectionState.done:
                        return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: ConstrainedBox(
                                constraints: BoxConstraints(
                                    maxWidth: max(screenWidth, minWidth)),
                                child: ListView.builder(
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
                                                id: homepageModel
                                                    .ids[index * 2],
                                                ranking: index * 2 + 1,
                                                title: homepageModel
                                                    .titles[index * 2],
                                                posterUrl: homepageModel
                                                    .posterUrls[index * 2]),
                                            if (index * 2 + 1 <
                                                homepageModel.ids.length)
                                              MovieCard(
                                                  id: homepageModel
                                                      .ids[index * 2 + 1],
                                                  ranking: index * 2 + 1 + 1,
                                                  title: homepageModel
                                                      .titles[index * 2 + 1],
                                                  posterUrl:
                                                      homepageModel.posterUrls[
                                                          index * 2 + 1])
                                          ]),
                                    );
                                  },
                                )));
                    }
                  } else {
                    return ErrorSign(callback: callback);
                  }
                })));
  }
}
