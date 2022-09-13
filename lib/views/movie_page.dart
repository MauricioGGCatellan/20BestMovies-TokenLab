import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import '../view-models/moviepage_model.dart';

class MoviePage extends StatefulWidget {
  const MoviePage({super.key, required this.id, required this.title});

  final int id;
  final String title;

  @override
  // ignore: no_logic_in_create_state
  State<MoviePage> createState() => _MoviePageState(id);
}

class _MoviePageState extends State<MoviePage> {
  final int id;
  late MoviepageModel moviepageModel;
  late Future dataRequest;

  _MoviePageState(this.id) {
    moviepageModel = MoviepageModel(id);
  }

  @override
  void initState() {
    super.initState();
    dataRequest = moviepageModel.requestData();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    const minHeight = 575.0;

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: max(screenHeight - 56, minHeight),
                ),
                child: FutureBuilder(
                    future: dataRequest,
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return const Text('Waiting!');
                        case ConnectionState.done:
                          final List<String> basicItems = [
                            "Title: ${moviepageModel.title}",
                            "Release date: ${moviepageModel.releaseDate}",
                            "Average vote: ${moviepageModel.voteAverage.toString()}",
                          ];

                          final List<String> detailedItems = [
                            "Tagline: ${moviepageModel.tagline}",
                            "Overview: ${moviepageModel.overview}"
                          ];
                          return Column(children: [
                            Row(children: [
                              CachedNetworkImage(
                                  imageUrl: moviepageModel.posterUrl,
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                          width: 200,
                                          height: 300, //talvez tenha que mudar
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: imageProvider))),
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) => Container(
                                      width: 200,
                                      height: 300,
                                      decoration: const BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/place_holder.png'))))),
                              SizedBox(
                                  height: 150,
                                  width: screenWidth - 200,
                                  child: ListView.builder(
                                      itemCount: basicItems.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          decoration: const BoxDecoration(
                                            border:
                                                Border(bottom: BorderSide()),
                                          ),
                                          child: ListTile(
                                            title: Text(basicItems[index]),
                                          ),
                                        );
                                      }))
                            ]),
                            SizedBox(
                                height: 125,
                                width: screenWidth,
                                child: ListView.builder(
                                    itemCount: detailedItems.length,
                                    itemBuilder: (context, index) {
                                      /*Widget showInfo;
                                      if (detailedItems[index] == '') {
                                        showInfo = Text('---');
                                      } else {
                                        showInfo = Text(detailedItems[index]); 
                                      }*/
                                      return Container(
                                        decoration: const BoxDecoration(
                                          border: Border(bottom: BorderSide()),
                                        ),
                                        child: ListTile(
                                          title: Text(detailedItems[index]),
                                        ),
                                      );
                                    }))
                          ]);
                        case ConnectionState.active:
                          return const Text('Error!');
                        case ConnectionState.none:
                          return const Text('Error!');
                      }
                    }))));
  }
}
