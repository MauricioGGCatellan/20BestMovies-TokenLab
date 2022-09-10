import 'package:flutter/material.dart';
import 'dart:math';

class MoviePage extends StatefulWidget {
  const MoviePage({super.key, required this.title});

  final String title;
  @override
  State<MoviePage> createState() => _MyMoviePageState();
}

class _MyMoviePageState extends State<MoviePage> {
  final basicItems = [
    'Title',
    'Release Date',
    'Score',
  ];

  final detailedItems = ['Tagline', 'Overview'];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    const minHeight = 375.0; //talvez tenha que mudar

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
                child: Column(children: [
                  Row(children: [
                    Container(
                        width: 200,
                        height: 100, //talvez tenha que mudar
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image:
                                  AssetImage('assets/images/place_holder.png')),
                        )),
                    SizedBox(
                        height: 150,
                        width: screenWidth - 200,
                        child: ListView.builder(
                            itemCount: basicItems.length,
                            itemBuilder: (context, index) {
                              return Container(
                                decoration: const BoxDecoration(
                                  border: Border(bottom: BorderSide()),
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
                            return Container(
                              decoration: const BoxDecoration(
                                border: Border(bottom: BorderSide()),
                              ),
                              child: ListTile(
                                title: Text(detailedItems[index]),
                              ),
                            );
                          }))
                ]))));
  }
}
