import 'package:flutter/material.dart';

class MovieCard extends StatefulWidget {
  const MovieCard(
      {super.key,
      required this.ranking,
      required this.title,
      required this.posterUrl});

  final String title;
  final String posterUrl;
  final int ranking;

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
            splashColor: Color.fromARGB(255, 1, 12, 23).withAlpha(30),
            onTap: () {
              debugPrint('Card tapped.');
            },
            child: SizedBox(
              width: 300,
              height: 300, //pode mudar
              child: Column(children: [
                Image.network(
                  widget.posterUrl,
                  errorBuilder: ((context, error, stackTrace) =>
                      Image.asset('assets/images/place_holder.png')),
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.ondemand_video),
                  title: Text('Number $widget.ranking'),
                  subtitle: Text(
                    widget.title,
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                ),
              ]),
            )));
  }
}
