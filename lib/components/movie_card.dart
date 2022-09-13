import 'package:flutter/material.dart';

class MovieCard extends StatefulWidget {
  const MovieCard(
      {super.key,
      required this.id,
      required this.ranking,
      required this.title,
      required this.posterUrl});

  final String title;
  final String posterUrl;
  final int id;
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
            splashColor: const Color.fromARGB(255, 1, 12, 23).withAlpha(30),
            onTap: () {
              Navigator.of(context).pushNamed('/movie',
                  arguments: <String, dynamic>{
                    "title": "Details about '${widget.title}'",
                    "id": widget.id
                  });
              //debugPrint('Card tapped.');
            },
            child: SizedBox(
              width: 300,
              height: 400, //pode mudar
              child: Column(children: [
                SizedBox(
                    width: 200,
                    height: 300,
                    child: Image.network(
                      widget.posterUrl,
                      errorBuilder: ((context, error, stackTrace) => SizedBox(
                          child:
                              Image.asset('assets/images/place_holder.png'))),
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    )),
                ListTile(
                  leading: const Icon(Icons.ondemand_video),
                  title: Text('Number ${widget.ranking}'),
                  subtitle: Text(
                    widget.title,
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                ),
              ]),
            )));
  }
}
