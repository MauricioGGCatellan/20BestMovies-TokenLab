import 'package:flutter/material.dart';

class MovieCard extends StatefulWidget {
  const MovieCard({super.key});

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
                Image(image: AssetImage('assets/images/place_holder.png')),
                ListTile(
                  leading: Icon(Icons.ondemand_video),
                  title: const Text('Number 1'),
                  subtitle: Text(
                    'The Movie Title',
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                ),
              ]),
            )));
  }
}
