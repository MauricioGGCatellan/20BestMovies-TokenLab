import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../view-models/moviepage_model.dart';
import 'package:movies_app/components/error_sign.dart';

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

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: FutureBuilder(
            future: dataRequest,
            builder: (context, snapshot) {
              if (!snapshot.hasError) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const Text('Waiting!');
                  case ConnectionState.done:
                    String genresTxt = "Genres: ";
                    for (String genre in moviepageModel.genres) {
                      genresTxt = '$genresTxt$genre, ';
                    }
                    genresTxt = genresTxt.substring(0, genresTxt.length - 2);

                    final List<String> basicItems = [
                      "Title: ${moviepageModel.title}",
                      "Release date: ${moviepageModel.releaseDate}",
                      "Average vote: ${moviepageModel.voteAverage.toString()}",
                      genresTxt,
                      "Tagline: ${moviepageModel.tagline}"
                    ];

                    final List<String> detailedItems = [
                      "Overview: ${moviepageModel.overview}"
                    ];

                    return ListView(children: [
                      Row(children: [
                        CachedNetworkImage(
                            imageUrl: moviepageModel.posterUrl,
                            imageBuilder: (context, imageProvider) => Container(
                                width: 200,
                                height: 300, //talvez tenha que mudar
                                decoration: BoxDecoration(
                                    image:
                                        DecorationImage(image: imageProvider))),
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) => Container(
                                width: 200,
                                height: 300,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/place_holder.png'))))),
                        Container(
                            alignment: Alignment.centerLeft,
                            child: SizedBox(
                                height: 300,
                                width: screenWidth - 200,
                                child: Column(
                                    children: basicItems.map((item) {
                                  return Expanded(
                                      child: Container(
                                          decoration: const BoxDecoration(
                                              border:
                                                  Border(top: BorderSide())),
                                          child: SizedBox(
                                            width: screenWidth - 200,
                                            child: Text(item,
                                                style: const TextStyle(
                                                    fontSize: 17)),
                                          )));
                                }).toList())))
                      ]),
                      SizedBox(
                          height: 250,
                          child: Column(
                              children: detailedItems.map((item) {
                            return Expanded(
                              child: Container(
                                  decoration: const BoxDecoration(
                                      border: Border(top: BorderSide())),
                                  child: Text(item,
                                      style: const TextStyle(fontSize: 20))),
                            );
                          }).toList()))
                    ]);
                  case ConnectionState.active:
                    return const Text('Error!');
                  case ConnectionState.none:
                    return const Text('Error!');
                }
              } else {
                return ErrorSign();
              }
            }));
  }
}
